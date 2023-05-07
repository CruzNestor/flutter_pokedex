import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pokedex/main.dart' as app;
import 'package:pokedex/src/core/constants/http_client_constants.dart';

extension on WidgetTester {
  Future<void> pumpSettleApp() async {
    app.main();
    await pumpAndSettle(const Duration(seconds: 2));
  }

  Future<void> nextPage() async {
    await tap(find.byTooltip('Next'));
  }

  Future<void> previousPage() async {
    await tap(find.byTooltip('Previous'));
  }

  Future<void> lastPage() async {
    await tap(find.byTooltip('Last page'));
  }

  Future<void> firstPage() async {
    await tap(find.byTooltip('First page'));
  }

  Future<void> openDialogPage() async {
    // Press button open dialog.
    // Verify if exist title 'Pages'.
    // Verify if exist in list are texts Page 1 and Page 3.
    await tap(find.byTooltip('Show pages'));
    await pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Pages'), findsOneWidget);
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 3'), findsOneWidget);
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late int lastPage;

  setUp((){
    lastPage = (HTTPClientConstants.TOTAL_POKEMON / HTTPClientConstants.limit).ceil();
  });

  testWidgets('Pagination buttons', (tester) async {
    await tester.pumpSettleApp();
    // Verify if exist GridView and the text 'Page: 1'
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Page: 1'), findsOneWidget);

    // Press next button and verify if exist the text 'Page: 2'
    await tester.nextPage();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: 2'), findsOneWidget);

    // Press previous button and verify if exist the text 'Page: 1'
    await tester.previousPage();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: 1'), findsOneWidget);

    // Press button last page and verify if exist the text 'Page: [lastPage]'
    await tester.lastPage();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: $lastPage'), findsOneWidget);

    // Press button first page and verify if exist the text 'Page: 1'
    await tester.firstPage();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: 1'), findsOneWidget);

    // Press button open dialog
    await tester.openDialogPage();

    // Press page 3 from list pages and expect the text 'Page: 3'
    await tester.tap(find.text('Page 3'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: 3'), findsOneWidget);

    // Press button open dialog
    await tester.openDialogPage();

    // Press page 1 from list pages and expect the text 'Page: 1'
    await tester.tap(find.text('Page 1'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Page: 1'), findsOneWidget);
  });

  testWidgets('Pokemon Detail', (tester) async {
    await tester.pumpSettleApp();
    // Press element 1 from GridView
    // Expect the CustomScrollWidget and name of first pokemon
    await tester.tap(find.text('#1'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.text('BULBASAUR'), findsOneWidget);

    // Press back button and expect GridView
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(GridView), findsOneWidget);      
  });

  testWidgets('Search Pokemon', (tester) async {
    await tester.pumpSettleApp();
    // Press Search button and expect TextField
    await tester.tap(find.byTooltip('Search'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Card), findsNothing);
    
    // Enter text in search field and expect Card with the pokemon
    await tester.enterText(find.byType(TextField), 'pikachu');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(Card), findsOneWidget);

    // Press card of pokemon and expect CustomScrollView
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CustomScrollView), findsOneWidget);
    
    // Press back button
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(Card), findsOneWidget);

    // Press back button
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(GridView), findsOneWidget);
  });
}