import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/src/features/pokemon_detail/data/models/pokemon_detail_model.dart';
import 'package:pokedex/src/features/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:pokedex/src/features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockPokemonDetailCubit extends MockCubit<PokemonDetailState> implements PokemonDetailCubit {}
class FakePokemonDetailState extends Fake implements PokemonDetailState {}

void main() {

  late MockPokemonDetailCubit mockPokemonDetailCubit;
  late PokemonDetailCubit pokemonDetailCubit;

  setUpAll(() async {
    mockPokemonDetailCubit = MockPokemonDetailCubit();
    final di = GetIt.instance;
    di.registerFactory<PokemonDetailCubit>(() => mockPokemonDetailCubit);
    pokemonDetailCubit = di<PokemonDetailCubit>();
  });

  group('PokemonDetailPage', () {
    const int tPokeId = 1;

    testWidgets('should show a loading widget', (tester) async {
      when(() => pokemonDetailCubit.state)
      .thenAnswer((_) => FakePokemonDetailState());

      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailPage(pokeId: tPokeId)
        )
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show a message widget', (tester) async {
      when(() => pokemonDetailCubit.state)
      .thenAnswer((_) => const PokemonDetailError(message: 'error'));

      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailPage(pokeId: tPokeId)
        )
      );
      
      expect(find.text('error'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show a CustomScrollView widget', (tester) async {
      
      final tPokemonDetailModel = PokemonDetailModel.fromJSON(
        json.decode(fixture('pokemon_detail.json'))
      );
      
      when(() => pokemonDetailCubit.state)
      .thenAnswer((_) => PokemonDetailData(
        pokemonDetail: tPokemonDetailModel
      ));

      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: PokemonDetailPage(pokeId: tPokeId)
          )
        )
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.text(tPokemonDetailModel.name.toUpperCase()), findsOneWidget);
      expect(find.text('HP'), findsOneWidget);
      expect(find.text('ATTACK'), findsOneWidget);
      expect(find.text('DEFENSE'), findsOneWidget);
      expect(find.text('SPECIAL-ATTACK'), findsOneWidget);
      expect(find.text('SPECIAL-DEFENSE'), findsOneWidget);
      expect(find.text('SPEED'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

  });
}