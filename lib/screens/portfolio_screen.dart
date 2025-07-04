import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/widgets/portfolio_summary_card.dart';
import 'package:stock_frontend/widgets/stock_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stock_frontend/services/api_service.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  bool _hasError = false;

  List<Stock> _holdings = [];
  List<double> _portfolioHistory = [];

  final List<String> holdingSymbols = ['AAPL', 'MSFT'];

  @override
  void initState() {
    super.initState();
    _loadHoldingsAndPerformance();
  }

  Future<void> _loadHoldingsAndPerformance() async {
    try {
      // 1. Obtain updated details of each action
      final List<Stock> stocks = await Future.wait(
        holdingSymbols.map((symbol) => _apiService.fetchStockDetails(symbol)),
      );

      // 2. Obtain price history for each
      final historyLists = await Future.wait(
        holdingSymbols.map((symbol) => _apiService.fetchPriceHistory(symbol)),
      );

      // 3. Calculate portfolio values daily
      final int days = historyLists.first.length;
      final List<double> portfolioValues = List.generate(days, (i) {
        double sum = 0;
        for (var prices in historyLists) {
          sum += prices[i];
        }
        return sum;
      });

      setState(() {
        _holdings = stocks;
        _portfolioHistory = portfolioValues;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _HoldingsList(holdings: _holdings),
            const SizedBox(height: 32),
            const Text('Portfolio Performance', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: AppColors.primary))
            else if (_hasError)
              const Center(child: Text('Error loading chart', style: TextStyle(color: Colors.red)))
            else
              _PortfolioChart(prices: _portfolioHistory),
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

class _PortfolioChart extends StatelessWidget {
  final List<double> prices;

  const _PortfolioChart({required this.prices});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                prices.length,
                    (i) => FlSpot(i.toDouble(), prices[i]),
              ),
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
