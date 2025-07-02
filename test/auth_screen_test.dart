import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_frontend/screens/auth_screen.dart';

void main() {
  group('AuthScreen Widget Tests', () {
    testWidgets('displays all expected widgets', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      // Check AppBar title
      expect(find.text('Sign In'), findsOneWidget);

      // Check for sign in header
      expect(find.text('Sign In to Your Account'), findsOneWidget);

      // Check for text fields
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(TextFormField, 'Email address'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      // Check for sign in button
      expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);

      // Check for forgot password link
      expect(find.widgetWithText(TextButton, 'Forgot password?'), findsOneWidget);

      // Check for social login divider
      expect(find.text('Or continue with'), findsOneWidget);

      // Check for social login buttons (2 icons)
      expect(find.byType(IconButton), findsNWidgets(2));

      // Check for sign up link
      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Sign up'), findsOneWidget);
    });

    testWidgets('tapping Sign In with empty fields shows validation errors',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: AuthScreen(),
            ),
          );

          // Tap Sign In without entering any text
          await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
          await tester.pump();

          // Check for validation errors
          expect(find.text('Please enter your email'), findsOneWidget);
          expect(find.text('Please enter your password'), findsOneWidget);
        });

    testWidgets('tapping Sign In with invalid email shows validation error',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: AuthScreen(),
            ),
          );

          // Enter invalid email and valid password
          await tester.enterText(find.widgetWithText(TextFormField, 'Email address'), 'invalid-email');
          await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
          await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
          await tester.pump();

          // Check for email validation error
          expect(find.text('Please enter a valid email'), findsOneWidget);
        });

    testWidgets('tapping Sign In with valid credentials triggers navigation',
            (WidgetTester tester) async {
          bool didNavigate = false;

          await tester.pumpWidget(
            MaterialApp(
              onGenerateRoute: (settings) {
                if (settings.name == '/portfolio') {
                  didNavigate = true;
                  return MaterialPageRoute(builder: (_) => const Placeholder());
                }
                return null;
              },
              home: const AuthScreen(),
            ),
          );

          // Enter valid credentials
          await tester.enterText(find.widgetWithText(TextFormField, 'Email address'), 'test@example.com');
          await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');

          // Tap Sign In
          await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
          await tester.pumpAndSettle();

          expect(didNavigate, isTrue);
        });

    testWidgets('tapping Forgot Password shows dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      // Tap Forgot Password
      await tester.tap(find.widgetWithText(TextButton, 'Forgot password?'));
      await tester.pump();

      // Check if dialog appears
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('Enter your email to receive a reset link'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3)); // Original 2 + dialog 1
    });

    testWidgets('tapping Sign Up navigates to registration screen', (WidgetTester tester) async {
      bool didNavigate = false;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == '/register') {
              didNavigate = true;
              return MaterialPageRoute(builder: (_) => const Placeholder());
            }
            return null;
          },
          home: const AuthScreen(),
        ),
      );

      // Tap Sign Up
      await tester.tap(find.widgetWithText(TextButton, 'Sign up'));
      await tester.pumpAndSettle();

      expect(didNavigate, isTrue);
    });
  });
}
