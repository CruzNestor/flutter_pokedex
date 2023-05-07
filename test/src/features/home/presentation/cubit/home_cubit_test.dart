import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/features/home/data/models/pokemon_page_model.dart';
import 'package:pokedex/src/features/home/domain/usecases/get_pokemon_page.dart';
import 'package:pokedex/src/features/home/presentation/cubit/home_cubit.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockGetPokemonPage extends Mock implements GetPokemonPage {}

void main() {
  late MockGetPokemonPage mockGetPokemonPageUseCase;
  late HomeCubit tHomeCubit;

  setUp((){
    mockGetPokemonPageUseCase = MockGetPokemonPage();
    tHomeCubit = HomeCubit(
      getPokemonPageUseCase: mockGetPokemonPageUseCase,
    );
  });

  group('HomeCubit', () {
    const int tPage = 1;
    final tPokemonPageModel = PokemonPageModel.fromJSON(
      json.decode(fixture('pokemon_page.json'))
    );

    test('the initial state should be HomeInitial', () => {
      expect(tHomeCubit.state, equals(HomeInitial()))
    });

    blocTest<HomeCubit, HomeState>(
      'should emit loading state and data state',
      build: () {
        when(() => mockGetPokemonPageUseCase.call(tPage))
        .thenAnswer((_) async => Right(tPokemonPageModel));
        return tHomeCubit;
      },
      act: (cubit) => cubit.getPokemonPage(tPage),
      expect: () => [isA<LoadingPokemonPage>(), isA<PokemonPageData>()],
    );

    blocTest<HomeCubit, HomeState>(
      'should emit loading state and error state',
      build: () {
        when(() => mockGetPokemonPageUseCase.call(tPage))
        .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return tHomeCubit; 
      },
      act: (bloc) => bloc.getPokemonPage(tPage),
      expect: () => [isA<LoadingPokemonPage>(), isA<PokemonPageError>()],
    );
  });
}