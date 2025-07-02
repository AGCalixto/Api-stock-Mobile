import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_frontend/screens/portfolio_screen.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/widgets/portfolio_summary_card.dart';
import 'package:stock_frontend/widgets/stock_card.dart';

void main() {
  group('PortfolioScreen Tests', () {
    testWidgets('renders all main components correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PortfolioScreen(),
        ),
      );

      // Verify app bar
      expect(find.text('Portfolio'), findsOneWidget);

      // Verify summary card is present
      expect(find.byType(PortfolioSummaryCard), findsOneWidget);

      // Verify holdings section
      expect(find.text('Your Holdings'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);

      // Verify stock cards (should be 2 based on the sample data)
      expect(find.byType(StockCard), findsNWidgets(2));

      // Verify performance section
      expect(find.text('Portfolio Performance'), findsOneWidget);
      expect(find.byType(Container).last, findsOneWidget); // Chart placeholder
    });

    testWidgets('displays correct stock information', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PortfolioScreen(),
        ),
      );

      // Verify first stock (AAPL)
      expect(find.text('AAPL'), findsOneWidget);
      expect(find.text('Apple Inc.'), findsOneWidget);
      expect(find.text('\$172.35'), findsOneWidget);
      expect(find.text('+1.44%'), findsOneWidget);

      // Verify second stock (MSFT)
      expect(find.text('MSFT'), findsOneWidget);
      expect(find.text('Microsoft Corp.'), findsOneWidget);
      expect(find.text('\$289.12'), findsOneWidget);
      expect(find.text('-0.42%'), findsOneWidget);
    });

    testWidgets('tapping View All button triggers navigation', (WidgetTester tester) async {
      bool didNavigate = false;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == '/all-holdings') {
              didNavigate = true;
              return MaterialPageRoute(builder: (_) => const Placeholder());
            }
            return null;
          },
          home: const PortfolioScreen(),
        ),
      );

      await tester.tap(find.text('View All'));
      await tester.pumpAndSettle();

      expect(didNavigate, isTrue);
    });

    testWidgets('displays correct number of stock cards based on holdings', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PortfolioScreen(),
        ),
      );

      // Initial count from the sample data
      expect(find.byType(StockCard), findsNWidgets(2));

      // You could also test with different data by creating a test version
      // of the PortfolioScreen that accepts mock data
    });

    testWidgets('performance chart placeholder is visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PortfolioScreen(),
        ),
      );

      final chartPlaceholder = find.text('Performance Chart Placeholder');
      expect(chartPlaceholder, findsOneWidget);

      final chartContainer = tester.widget<Container>(find.byType(Container).last);
      expect(chartContainer.decoration, isA<BoxDecoration>());
    });

    testWidgets('stock cards show details when showDetails is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PortfolioScreen(),
        ),
      );

      // Verify that additional details are visible (since showDetails is true)
      expect(find.text('Market Cap'), findsNWidgets(2));
      expect(find.text('Volume'), findsNWidgets(2));
      expect(find.text('P/E Ratio'), findsNWidgets(2));
    });
  });

  // Additional test group for different states
  group('PortfolioScreen Edge Cases', () {
    testWidgets('handles empty holdings list', (WidgetTester tester) async {
      // Create a test version of the screen with empty holdings
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PortfolioScreen(), // Would need to modify to accept empty list
          ),
        ),
      );

      // Alternative approach: mock the data source if you're using one
      // For now, this test is just a placeholder since your current implementation
      // always has the two sample stocks
    });

    testWidgets('handles loading state if data is fetched asynchronously', (WidgetTester tester) async {
      // This would be relevant if you later modify the screen to fetch data
      // Currently just a placeholder for future implementation
    });
  });
}
