import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex/src/features/home/data/models/pokemon_page_model.dart';
import 'package:pokedex/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:pokedex/src/features/home/presentation/pages/home_page.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}
class FakeHomeState extends Fake implements HomeState {}

void main() {

  late MockHomeCubit mockHomeCubit;
  late HomeCubit homeCubit;

  setUpAll(() async {
    mockHomeCubit = MockHomeCubit();
    final di = GetIt.instance;
    di.registerFactory<HomeCubit>(() => mockHomeCubit);
    homeCubit = di<HomeCubit>();
  });

  group('HomePage', () {

    testWidgets('should show a loading widget', (tester) async {
      when(() => homeCubit.state)
      .thenAnswer((_) => FakeHomeState());

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage()
        )
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('should show a message widget', (tester) async {
      when(() => homeCubit.state)
      .thenAnswer((_) => const PokemonPageError(message: 'error', page: 1));

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage()
        )
      );

      expect(find.text('error'), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show a gridview widget', (tester) async {
      
      final tPokemonPageModel = PokemonPageModel.fromJSON(
        json.decode(fixture('pokemon_page.json'))
      );
      
      when(() => homeCubit.state)
      .thenAnswer((_) => PokemonPageData(
        page: 1,
        pokemonPage: tPokemonPageModel,
      ));

      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: HomePage()
          )
        )
      );

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

  });
}