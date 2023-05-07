import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/features/pokemon_detail/data/models/pokemon_detail_model.dart';
import 'package:pokedex/src/features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';
import 'package:pokedex/src/features/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockGetPokemonDetail extends Mock implements GetPokemonDetail {}

void main() {
  late MockGetPokemonDetail mockGetPokemonDetail;
  late PokemonDetailCubit tPokemonDetailCubit;

  setUp((){
    mockGetPokemonDetail = MockGetPokemonDetail();
    tPokemonDetailCubit = PokemonDetailCubit(
      getPokemonDetailUseCase: mockGetPokemonDetail
    );
  });

  group('PokemonDetailCubit', () {
    const int tPokeId = 1;
    final tPokemonDetailModel = PokemonDetailModel.fromJSON(
      json.decode(fixture('pokemon_detail.json'))
    );

    test('the initial state should be PokemonDetailInitial', () => {
      expect(tPokemonDetailCubit.state, equals(PokemonDetailInitial()))
    });

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit loading state and data state',
      build: () {
        when(() => mockGetPokemonDetail.call(tPokeId))
        .thenAnswer((_) async => Right(tPokemonDetailModel));
        return tPokemonDetailCubit;
      },
      act: (cubit) => cubit.getPokemonData(tPokeId),
      expect: () => [isA<LoadingPokemonDetail>(), isA<PokemonDetailData>()],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit loading state and error state',
      build: () {
        when(() => mockGetPokemonDetail.call(tPokeId))
        .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return tPokemonDetailCubit; 
      },
      act: (cubit) => cubit.getPokemonData(tPokeId),
      expect: () => [isA<LoadingPokemonDetail>(), isA<PokemonDetailError>()],
    );
  });
}