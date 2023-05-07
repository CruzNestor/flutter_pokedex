import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/src/features/search_pokemon/data/models/searched_pokemon_model.dart';
import 'package:pokedex/src/features/search_pokemon/domain/entities/searched_pokemon.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('SearchedPokemonModel', () {
    final Map<String, dynamic> tJSON = json.decode(fixture('searched_pokemon.json'));
    final tSearchedPokemonModel = SearchedPokemonModel.fromJSON(tJSON);

    test('model should be a subclass of entity', () {
      expect(tSearchedPokemonModel, isA<SearchedPokemon>());
    });

    test('should return a validate model', () {
      final result = SearchedPokemonModel.fromJSON(tJSON);
      expect(result, tSearchedPokemonModel);
    });
  });
}