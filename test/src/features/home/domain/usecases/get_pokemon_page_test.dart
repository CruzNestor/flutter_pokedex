import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/features/home/data/models/pokemon_page_model.dart';
import 'package:pokedex/src/features/home/domain/repositories/home_repository.dart';
import 'package:pokedex/src/features/home/domain/usecases/get_pokemon_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetPokemonPage usecase;
  late MockHomeRepository mockHomeRepository;

  setUp((){
    mockHomeRepository = MockHomeRepository();
    usecase = GetPokemonPage(repository: mockHomeRepository);
  });

  test('Should return a instance of PokemonPageModel', () async {
    const int tPage = 1;
    final tPokemonPageModel = PokemonPageModel.fromJSON(
      json.decode(fixture('pokemon_page.json'))
    );

    when(() => mockHomeRepository.getPokemonPage(page: tPage))
    .thenAnswer((_) async {
      return Right(tPokemonPageModel);
    });

    final result = await usecase(tPage);

    expect(result, Right(tPokemonPageModel));
    verify(() => mockHomeRepository.getPokemonPage(page: tPage));
    verifyNoMoreInteractions(mockHomeRepository);
  });
} 