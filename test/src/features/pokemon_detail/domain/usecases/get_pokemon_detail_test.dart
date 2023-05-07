import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/features/pokemon_detail/data/models/pokemon_detail_model.dart';
import 'package:pokedex/src/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:pokedex/src/features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockPokemonDetailRepository extends Mock implements PokemonDetailRepository {}

void main() {
  late MockPokemonDetailRepository mockPokemonDetailRepository;
  late GetPokemonDetail usecase;

  setUp((){
    mockPokemonDetailRepository = MockPokemonDetailRepository();
    usecase = GetPokemonDetail(repository: mockPokemonDetailRepository);
  });

  test('Should return a instance of PokemonDetailModel', () async {
    int tPokeId = 1;
    final tPokemonDetailModel = PokemonDetailModel.fromJSON(
      json.decode(fixture('pokemon_detail.json'))
    );
    
    when(() => mockPokemonDetailRepository.getPokemonDetail(pokeId: tPokeId))
    .thenAnswer((_) async {
      return Right(tPokemonDetailModel);
    });

    final result = await usecase(tPokeId);

    expect(result, Right(tPokemonDetailModel));
    verify(() => mockPokemonDetailRepository.getPokemonDetail(pokeId: tPokeId));
    verifyNoMoreInteractions(mockPokemonDetailRepository);
  });
} 