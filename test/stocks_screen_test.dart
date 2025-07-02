import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_frontend/screens/stocks_screen.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/widgets/stock_card.dart'; // Make sure to import this

void main() {
  // Complete test data with all required Stock parameters
  final testStocks = [
    Stock(
      symbol: 'AAPL',
      name: 'Apple Inc.',
      price: 172.35,
      change: 2.45,
      changePercent: 1.44,
      marketCap: 2.87e12,
      volume: 54.3e6,
      high: 182.94,
      low: 124.17,
      peRatio: 29.34,
    ),
    Stock(
      symbol: 'MSFT',
      name: 'Microsoft Corp.',
      price: 289.12,
      change: -1.23,
      changePercent: -0.42,
      marketCap: 2.19e12,
      volume: 32.1e6,
      high: 298.76,
      low: 245.12,
      peRatio: 34.12,
    ),
  ];

  // Create a testable widget
  Widget createTestableWidget() {
    return MaterialApp(
      home: StocksScreen(),
    );
  }

  group('StocksScreen Tests', () {
    testWidgets('displays loading indicator initially', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows app bar with correct title', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      expect(find.text('Market Stocks'), findsOneWidget);
    });

    testWidgets('displays search field and dropdowns', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));
    });

    testWidgets('displays stocks when data is loaded', (tester) async {
      final widget = createTestableWidget();
      await tester.pumpWidget(widget);

      // Get the state and update it directly
      final state = tester.state(find.byType(StocksScreen)) as dynamic;
      state.setState(() {
        state._stocks = testStocks;
        state._isLoading = false;
      });
      await tester.pump();

      expect(find.byType(StockCard), findsNWidgets(2));
      expect(find.text('AAPL'), findsOneWidget);
      expect(find.text('MSFT'), findsOneWidget);
    });
  });
}
