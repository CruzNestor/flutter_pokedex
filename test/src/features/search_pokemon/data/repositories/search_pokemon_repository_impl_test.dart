import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/core/platform/network_info.dart';
import 'package:pokedex/src/features/search_pokemon/data/datasources/search_pokemon_remote_datasource.dart';
import 'package:pokedex/src/features/search_pokemon/data/models/searched_pokemon_model.dart';
import 'package:pokedex/src/features/search_pokemon/data/repositories/search_pokemon_repository_impl.dart';
import 'package:pokedex/src/features/search_pokemon/domain/entities/searched_pokemon.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSearchPokemonRemoteDataSource extends Mock implements SearchPokemonRemoteDataSource {}

void main() {
  late SearchPokemonRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockSearchPokemonRemoteDataSource mockRemote;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockSearchPokemonRemoteDataSource();
    tRepository = SearchPokemonRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is online', () {
    const String tName = 'pikachu';
    final tSearchedModel = SearchedPokemonModel.fromJSON(
      json.decode(fixture('searched_pokemon.json'))
    );
    
    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('Should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.searchPokemon(text: tName))
      .thenAnswer((_) async => Future.value(tSearchedModel));

      final result = await tRepository.searchPokemon(text: tName);

      verify(() => mockRemote.searchPokemon(text: tName));
      expect(result, equals(Right(tSearchedModel)));
    });

    test('Should return a failure when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.searchPokemon(text: tName))
      .thenThrow(ServerException());

      final result = await tRepository.searchPokemon(text: tName);

      verify(() => mockRemote.searchPokemon(text: tName));
      expect(result, isA<Left<Failure, SearchedPokemon>>());
    });

  });
  
}