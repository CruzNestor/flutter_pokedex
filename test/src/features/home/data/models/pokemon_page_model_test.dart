import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/src/features/home/data/models/pokemon_page_model.dart';
import 'package:pokedex/src/features/home/domain/entities/pokemon_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('PokemonPageModel', () {
    final Map<String, dynamic> tJSON = json.decode(fixture('pokemon_page.json'));
    final tPokePaginationModel = PokemonPageModel.fromJSON(tJSON);

    test('model should be a subclass of entity', () {
      expect(tPokePaginationModel, isA<PokemonPage>());
    });

    test('Should return a validate model', () {
      final result = PokemonPageModel.fromJSON(tJSON);
      expect(result, tPokePaginationModel);
    });
  });
}