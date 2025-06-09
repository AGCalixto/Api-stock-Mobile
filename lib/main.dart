import 'package:flutter/material.dart';
import 'package:stock_frontend/screens/home_screen.dart';
import 'package:stock_frontend/screens/stocks_screen.dart';
import 'package:stock_frontend/screens/stock_detail_screen.dart';
import 'package:stock_frontend/screens/portfolio_screen.dart';
import 'package:stock_frontend/screens/pro_screen.dart';
import 'package:stock_frontend/screens/about_screen.dart';
import 'package:stock_frontend/screens/auth_screen.dart';
import 'constants/colors.dart';

void main() {
  runApp(const StockMarketApp());
}

class StockMarketApp extends StatelessWidget {
  const StockMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StockMarket',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Amiko',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Sen', fontSize: 36, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Sen', fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontFamily: 'Sen', fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Sen', fontSize: 20, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontFamily: 'Sen', fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: 'Sen', fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'Amiko', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'Amiko', fontSize: 14),
          bodySmall: TextStyle(fontFamily: 'Amiko', fontSize: 12),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontFamily: 'Sen',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.cardBackground,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/stocks': (context) => const StocksScreen(),
        '/stock-detail': (context) => const StockDetailScreen(),
        '/portfolio': (context) => const PortfolioScreen(),
        '/pro': (context) => const ProScreen(),
        '/about': (context) => const AboutScreen(),
        '/auth': (context) => const AuthScreen(),
      },
    );
  }
}