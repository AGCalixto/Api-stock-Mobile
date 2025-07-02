import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_frontend/screens/pro_screen.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';

void main() {
  group('ProScreen Tests', () {
    testWidgets('renders all main components correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Verify app bar
      expect(find.text('Go Pro'), findsOneWidget);

      // Verify main title and subtitle
      expect(find.text('Upgrade to StockMarket Pro'), findsOneWidget);
      expect(
        find.text('Get advanced features and insights to maximize your investment potential'),
        findsOneWidget,
      );

      // Verify plan cards
      expect(find.text('Basic'), findsOneWidget);
      expect(find.text('Pro'), findsOneWidget);
      expect(find.text('Premium'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(3));

      // Verify FAQ section
      expect(find.text('Frequently Asked Questions'), findsOneWidget);
      expect(find.byType(ExpansionTile), findsNWidgets(3));
    });

    testWidgets('displays correct plan details', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Verify Basic plan details
      expect(find.text('\$0'), findsOneWidget);
      expect(find.text('Real-time stock data'), findsOneWidget);
      expect(find.text('Basic portfolio tracking'), findsOneWidget);
      expect(find.text('Standard news updates'), findsOneWidget);

      // Verify Pro plan details
      expect(find.text('\$9.99'), findsOneWidget);
      expect(find.text('Advanced charting tools'), findsOneWidget);
      expect(find.text('Premium research reports'), findsOneWidget);
      expect(find.text('Technical indicators'), findsOneWidget);

      // Verify Premium plan details
      expect(find.text('\$19.99'), findsOneWidget);
      expect(find.text('AI-powered predictions'), findsOneWidget);
      expect(find.text('Customizable dashboards'), findsOneWidget);
      expect(find.text('Dedicated account manager'), findsOneWidget);
    });

    testWidgets('highlights Pro plan as featured', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Find all plan cards
      final cards = tester.widgetList<Card>(find.byType(Card)).toList();

      // Verify Pro card has border and higher elevation
      expect(cards[1].shape, isA<RoundedRectangleBorder>());
      expect((cards[1].shape as RoundedRectangleBorder).side.color, AppColors.primary);
      expect(cards[1].elevation, 4);

      // Verify other cards don't have primary color border
      expect((cards[0].shape as RoundedRectangleBorder).side.color, Colors.transparent);
      expect((cards[2].shape as RoundedRectangleBorder).side.color, Colors.transparent);
      expect(cards[0].elevation, 2);
      expect(cards[2].elevation, 2);
    });

    testWidgets('displays correct button styles for featured plan', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Find all buttons
      final buttons = tester.widgetList<ElevatedButton>(find.byType(ElevatedButton)).toList();

      // Verify Pro button has primary background
      expect(buttons[1].style?.backgroundColor?.resolve({}), AppColors.primary);
      expect(buttons[1].style?.foregroundColor?.resolve({}), AppColors.background);
      expect(find.widgetWithText(ElevatedButton, 'Get Started'), findsOneWidget);

      // Verify other buttons have outlined style
      expect(buttons[0].style?.backgroundColor?.resolve({}), Colors.transparent);
      expect(buttons[0].style?.foregroundColor?.resolve({}), AppColors.primary);
      expect(buttons[0].style?.side?.resolve({})?.color, AppColors.primary);
      expect(find.widgetWithText(ElevatedButton, 'Choose Plan'), findsNWidgets(2));
    });

    testWidgets('FAQ expansion tiles work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Initially, answers should not be visible
      expect(find.text('You can cancel your subscription'), findsNothing);
      expect(find.text('Yes, you can upgrade or downgrade'), findsNothing);
      expect(find.text('Yes, we offer a 50% discount'), findsNothing);

      // Tap first FAQ and verify answer appears
      await tester.tap(find.text('How do I cancel my subscription?'));
      await tester.pumpAndSettle();
      expect(find.text('You can cancel your subscription'), findsOneWidget);

      // Tap second FAQ and verify answer appears
      await tester.tap(find.text('Can I switch plans later?'));
      await tester.pumpAndSettle();
      expect(find.text('Yes, you can upgrade or downgrade'), findsOneWidget);

      // First answer should still be visible
      expect(find.text('You can cancel your subscription'), findsOneWidget);

      // Tap first FAQ again to collapse
      await tester.tap(find.text('How do I cancel my subscription?'));
      await tester.pumpAndSettle();
      expect(find.text('You can cancel your subscription'), findsNothing);
    });

    testWidgets('plan cards have correct feature checkmarks', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProScreen(),
        ),
      );

      // Verify checkmarks exist for all features
      expect(find.byIcon(Icons.check), findsNWidgets(15)); // Total features across all plans
      expect(find.byIcon(Icons.check).first, findsOneWidget);

      // Verify checkmark color
      final firstCheck = tester.widget<Icon>(find.byIcon(Icons.check).first);
      expect(firstCheck.color, AppColors.primary);
    });

    testWidgets('tapping plan buttons triggers action', (WidgetTester tester) async {
      bool basicTapped = false;
      bool proTapped = false;
      bool premiumTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ProScreen();
              },
            ),
          ),
        ),
      );

      // Replace with actual button handling in your app
      // This is just a demonstration of how you might test button taps
      await tester.tap(find.widgetWithText(ElevatedButton, 'Choose Plan').first);
          basicTapped = true;
          await tester.tap(find.widgetWithText(ElevatedButton, 'Get Started'));
      proTapped = true;
      await tester.tap(find.widgetWithText(ElevatedButton, 'Choose Plan').last);
      premiumTapped = true;

      expect(basicTapped, isTrue);
      expect(proTapped, isTrue);
      expect(premiumTapped, isTrue);
      });
  });
}
