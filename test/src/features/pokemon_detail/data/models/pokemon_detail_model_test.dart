import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/src/features/pokemon_detail/data/models/pokemon_detail_model.dart';
import 'package:pokedex/src/features/pokemon_detail/domain/entities/pokemon_detail.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {

  group('PokemonDetailModel', () {

    final Map<String, dynamic> tJSON = json.decode(fixture('pokemon_detail.json'));
    final tPokemonDetailModel = PokemonDetailModel.fromJSON(tJSON);

    test('model should be a subclass of entity', () {
      expect(tPokemonDetailModel, isA<PokemonDetail>());
    });

    test('should return a validate model', () {
      final result = PokemonDetailModel.fromJSON(tJSON);
      expect(result, tPokemonDetailModel);
    });
  });
}