import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_frontend/screens/about_screen.dart';

void main() {
  testWidgets('renders AboutScreen with team members and section titles', (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify section titles are rendered
    expect(find.text('About Us'), findsOneWidget);
    expect(find.text('Project Overview'), findsOneWidget);
    expect(find.text('Our Philosophy'), findsOneWidget);
    expect(find.text('Our Team'), findsOneWidget);
    expect(find.text('Tech Stack'), findsOneWidget);
    expect(find.text('Reflection & Acknowledgment'), findsOneWidget);

    // Verify at least one team member card is rendered
    expect(find.text('Diego Acosta'), findsOneWidget);
    expect(find.text('Miguel Garcia'), findsOneWidget);

    // Verify special thanks names
    expect(find.text('Mr. Erkin Erdogan'), findsOneWidget);
    expect(find.text('Dr. Mohammed Nazeh Alimam'), findsOneWidget);
  });
}
