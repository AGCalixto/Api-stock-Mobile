import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/services/api_service.dart';
import 'package:fl_chart/fl_chart.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final ApiService _apiService = ApiService();
  late Stock _stock;
  List<double> _priceHistory = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final symbol = ModalRoute.of(context)!.settings.arguments as String? ?? 'AAPL';
    _fetchStock(symbol);
  }

  Future<void> _fetchStock(String symbol) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final stock = await _apiService.fetchStockDetails(symbol);
      final history = await _apiService.fetchPriceHistory(symbol);
      setState(() {
        _stock = stock;
        _priceHistory = history;
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
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (_hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Stock Details')),
        body: const Center(
          child: Text('Failed to load stock data', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_stock.symbol)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _StockHeader(stock: _stock),
            const SizedBox(height: 16),
            _PriceSection(stock: _stock),
            const SizedBox(height: 32),
            _priceHistory.isEmpty
                ? const SizedBox(height: 300, child: Center(child: CircularProgressIndicator(color: AppColors.primary))) // better feedback
                : PriceChart(prices: _priceHistory),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  // Responsive: stack vertically
                  return Column(
                    children: [
                      _KeyInfoTable(stock: _stock),
                      const SizedBox(height: 32),
                      const _RelatedNews(),
                    ],
                  );
                } else {
                  // Side by side
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _KeyInfoTable(stock: _stock)),
                      const SizedBox(width: 32),
                      const Expanded(child: _RelatedNews()),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StockHeader extends StatelessWidget {
  final Stock stock;

  const _StockHeader({required this.stock});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 30,
          child: Text(
            stock.symbol.substring(0, 1),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                color: AppColors.background),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stock.symbol,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
            Text(stock.name, style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }
}

class _PriceSection extends StatelessWidget {
  final Stock stock;

  const _PriceSection({required this.stock});

  @override
  Widget build(BuildContext context) {
    final bool isUp = stock.change >= 0;
    final Color color = isUp ? AppColors.upTrend : AppColors.downTrend;
    final String symbol = isUp ? '▲' : '▼';

    return Row(
      children: [
        Text('\$${stock.price.toStringAsFixed(2)}',
            style: AppStyles.stockPrice.copyWith(color: Colors.white)),
        const SizedBox(width: 16),
        Text(
          '$symbol ${stock.change.abs().toStringAsFixed(2)} (${stock.changePercent.abs().toStringAsFixed(2)}%)',
          style: AppStyles.stockChange.copyWith(color: color),
        ),
      ],
    );
  }
}

class PriceChart extends StatelessWidget {
  final List<double> prices;

  const PriceChart({required this.prices});

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

class _KeyInfoTable extends StatelessWidget {
  final Stock stock;

  const _KeyInfoTable({required this.stock});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Key Information', style: AppStyles.sectionHeader),
        const SizedBox(height: 16),
        Table(
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Market Cap',
                  style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '\$${(stock.marketCap / 1e9).toStringAsFixed(1)}B',
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Volume',
                  style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${(stock.volume / 1e6).toStringAsFixed(1)}M',
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            // Add more rows as needed
          ],
        ),
      ],
    );
  }
}

class _RelatedNews extends StatelessWidget {
  const _RelatedNews();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Related News', style: AppStyles.sectionHeader),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Apple announces new product line', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text(
                'Apple Inc. announced a new line of products set to launch next quarter...',
                style: TextStyle(color: AppColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16),
              Text('Tech stocks surge', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text(
                'Tech stocks, including Apple, saw a significant surge in trading today...',
                style: TextStyle(color: AppColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
