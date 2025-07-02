import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/widgets/portfolio_summary_card.dart';
import 'package:stock_frontend/widgets/stock_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Stock> holdings = [
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
      // Add more holdings as needed
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PortfolioSummaryCard(
              accountBalance: 25901,
              portfolioValue: 123500,
              portfolioChange: 3450,
              portfolioChangePercent: 2.87,
              dailyChange: 2150,
              dailyChangePercent: 1.78,
              totalGainLoss: 23500,
              totalGainLossPercent: 23.5,
            ),
            const SizedBox(height: 32),
            _HoldingsList(holdings: holdings),
            const SizedBox(height: 32),
            const Text('Portfolio Performance', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            const _PerformanceChart(),
          ],
        ),
      ),
    );
  }
}

class _HoldingsList extends StatelessWidget {
  final List<Stock> holdings;

  const _HoldingsList({required this.holdings});

  @override
  Widget build(BuildContext context) {
    if (holdings.isEmpty) {
      return const Center(child: Text('No holdings available.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your Holdings', style: AppStyles.sectionHeader),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...holdings.map(
              (stock) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: StockCard(stock: stock, showDetails: true),
          ),
        ),
      ],
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Performance Chart Placeholder',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
