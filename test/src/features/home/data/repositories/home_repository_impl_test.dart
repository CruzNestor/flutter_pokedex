import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/src/core/constants/http_client_constants.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/errors/failures.dart';
import 'package:pokedex/src/core/platform/network_info.dart';
import 'package:pokedex/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pokedex/src/features/home/data/models/pokemon_page_model.dart';
import 'package:pokedex/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:pokedex/src/features/home/domain/entities/pokemon_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late HomeRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockHomeRemoteDataSource mockRemote;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockHomeRemoteDataSource();
    tRepository = HomeRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is online', () {
    const int tPage = 1;
    final tPokemonPageModel = PokemonPageModel.fromJSON(
      json.decode(fixture('pokemon_page.json'))
    );
    
    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.getPokemonPage(offset: 0, limit: HTTPClientConstants.limit))
      .thenAnswer((_) async => Future.value(tPokemonPageModel));

      final result = await tRepository.getPokemonPage(page: tPage);

      verify(() => mockRemote.getPokemonPage(offset: 0, limit: HTTPClientConstants.limit));
      expect(result, equals(Right(tPokemonPageModel)));
    });

    test('should return a failure when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.getPokemonPage(offset: 0, limit: HTTPClientConstants.limit))
      .thenThrow(ServerException());

      final result = await tRepository.getPokemonPage(page: tPage);

      verify(() => mockRemote.getPokemonPage(offset: 0, limit: HTTPClientConstants.limit));
      expect(result, isA<Left<Failure, PokemonPage>>());
    });

  });
  
}