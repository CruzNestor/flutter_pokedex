import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/features/search_pokemon/data/models/searched_pokemon_model.dart';
import 'package:pokedex/src/features/search_pokemon/domain/usecases/search_pokemon.dart';
import 'package:pokedex/src/features/search_pokemon/presentation/cubit/search_pokemon_cubit.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSearchPokemon extends Mock implements SearchPokemon {}

void main() {
  late MockSearchPokemon mockSearchPokemonUseCase;
  late SearchPokemonCubit tSearchPokemonCubit;

  setUp((){
    mockSearchPokemonUseCase = MockSearchPokemon();
    tSearchPokemonCubit = SearchPokemonCubit(
      searchPokemonUseCase: mockSearchPokemonUseCase
    );
  });

  group('SearchPokemonCubit', () {
    const String tSearch = '';
    final SearchedPokemonModel tSearchedPokemonModel = SearchedPokemonModel.fromJSON(
      json.decode(fixture('searched_pokemon.json'))
    );

    test('the initial state should be SearchPokemonInitial', () => {
      expect(tSearchPokemonCubit.state, equals(SearchPokemonInitial()))
    });

    blocTest<SearchPokemonCubit, SearchPokemonState>(
      'should emit loading state and data state',
      build: () {
        when(() => mockSearchPokemonUseCase.call(tSearch))
        .thenAnswer((_) async => Right(tSearchedPokemonModel));
        return tSearchPokemonCubit;
      },
      act: (cubit) => cubit.searchPokemon(tSearch),
      expect: () => [isA<LoadingSearchPokemon>(), isA<SearchPokemonData>()],
    );

    blocTest<SearchPokemonCubit, SearchPokemonState>(
      'should emit loading state and error state',
      build: () {
        when(() => mockSearchPokemonUseCase.call(tSearch))
        .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return tSearchPokemonCubit; 
      },
      act: (cubit) => cubit.searchPokemon(tSearch),
      expect: () => [isA<LoadingSearchPokemon>(), isA<SearchPokemonError>()],
    );
  });
}