import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/features/search_pokemon/data/models/searched_pokemon_model.dart';
import 'package:pokedex/src/features/search_pokemon/domain/repositories/search_pokemon_repository.dart';
import 'package:pokedex/src/features/search_pokemon/domain/usecases/search_pokemon.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSearchRepository extends Mock implements SearchPokemonRepository {}

void main() {
  late MockSearchRepository mockSearchRepository;
  late SearchPokemon usecase;

  setUp((){
    mockSearchRepository = MockSearchRepository();
    usecase = SearchPokemon(repository: mockSearchRepository);
  });

  test('Should return a instance of SearchedPokemonModel', () async {
    String tName = 'pikachu';
    SearchedPokemonModel tSearchedPokemonModel = SearchedPokemonModel.fromJSON(
      json.decode(fixture('searched_pokemon.json'))
    );

    when(() => mockSearchRepository.searchPokemon(text: tName))
    .thenAnswer((_) async {
      return Right(tSearchedPokemonModel);
    });

    final result = await usecase(tName);

    expect(result, Right(tSearchedPokemonModel));
    verify(() => mockSearchRepository.searchPokemon(text: tName));
    verifyNoMoreInteractions(mockSearchRepository);
  });
} 