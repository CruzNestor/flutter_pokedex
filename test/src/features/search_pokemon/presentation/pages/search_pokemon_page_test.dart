import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/src/features/search_pokemon/data/models/searched_pokemon_model.dart';
import 'package:pokedex/src/features/search_pokemon/presentation/cubit/search_pokemon_cubit.dart';
import 'package:pokedex/src/features/search_pokemon/presentation/pages/search_pokemon_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSearchPokemonCubit extends MockCubit<SearchPokemonState> implements SearchPokemonCubit {}
class FakeSearchPokemonState extends Fake implements SearchPokemonState {}

void main() {

  late MockSearchPokemonCubit mockSearchPokemonCubit;
  late SearchPokemonCubit searchPokemonCubit;

  setUpAll(() async {
    mockSearchPokemonCubit = MockSearchPokemonCubit();
    final di = GetIt.instance;
    di.registerFactory<SearchPokemonCubit>(() => mockSearchPokemonCubit);
    searchPokemonCubit = di<SearchPokemonCubit>();
  });

  group('SearchPokemonPage', () {

    testWidgets('when the page loads for the first time the body is empty', (tester) async {
      when(() => searchPokemonCubit.state)
      .thenAnswer((_) => FakeSearchPokemonState());

      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPokemonPage()
        )
      );
      
      expect(find.byType(Card), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show a message widget', (tester) async {
      when(() => searchPokemonCubit.state)
      .thenAnswer((_) => const SearchPokemonError(message: 'error'));

      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPokemonPage()
        )
      );

      expect(find.text('error'), findsOneWidget);
      expect(find.byType(Card), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show a card widget', (tester) async {
      
      final SearchedPokemonModel tSearchedPokemonModel = SearchedPokemonModel.fromJSON(
        json.decode(fixture('searched_pokemon.json'))
      );
      
      when(() => searchPokemonCubit.state)
      .thenAnswer((_) => SearchPokemonData(
        searchedPokemon: tSearchedPokemonModel
      ));

      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: SearchPokemonPage()
          )
        )
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

  });
}