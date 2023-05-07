import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/core/platform/network_info.dart';
import 'package:pokedex/src/features/pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import 'package:pokedex/src/features/pokemon_detail/data/models/pokemon_detail_model.dart';
import 'package:pokedex/src/features/pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import 'package:pokedex/src/features/pokemon_detail/domain/entities/pokemon_detail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockPokemonDetailRemoteDataSource extends Mock implements PokemonDetailRemoteDataSource {}

void main() {
  late PokemonDetailRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockPokemonDetailRemoteDataSource mockRemote;

  setUpAll((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockPokemonDetailRemoteDataSource();
    tRepository = PokemonDetailRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is online', () {
    const int tPokeId = 1;
    final tPokemonDetailModel = PokemonDetailModel.fromJSON(
      json.decode(fixture('pokemon_detail.json'))
    );

    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    
    test('should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.getPokemonDetail(pokeId: tPokeId))
      .thenAnswer((_) async => Future.value(tPokemonDetailModel));

      final result = await tRepository.getPokemonDetail(pokeId: tPokeId);

      verify(() => mockRemote.getPokemonDetail(pokeId: tPokeId));
      expect(result, equals(Right(tPokemonDetailModel)));
    });

    test('should return a failure when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.getPokemonDetail(pokeId: tPokeId))
      .thenThrow(ServerException());

      final result = await tRepository.getPokemonDetail(pokeId: tPokeId);

      verify(() => mockRemote.getPokemonDetail(pokeId: tPokeId));
      expect(result, isA<Left<Failure, PokemonDetail>>());
    });

  });
  
}