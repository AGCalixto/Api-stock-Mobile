import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/services/api_service.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final ApiService _apiService = ApiService();
  late Stock _stock;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final symbol = ModalRoute.of(context)!.settings.arguments as String? ?? 'AAPL';
    _fetchStock(symbol);
  }

  Future<void> _fetchStock(String symbol) async {
    setState(() => _isLoading = true);
    final stock = await _apiService.fetchStockDetails(symbol);
    setState(() {
      _stock = stock;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    final bool isUp = _stock.change >= 0;
    final Color color = isUp ? AppColors.upTrend : AppColors.downTrend;
    final String symbol = isUp ? '▲' : '▼';

    return Scaffold(
      appBar: AppBar(
        title: Text(_stock.symbol),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 30,
                  child: Text(
                    _stock.symbol.substring(0, 1),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_stock.symbol, style: Theme.of(context).textTheme.headlineMedium),
                    Text(_stock.name, style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '\$${_stock.price.toStringAsFixed(2)}',
                  style: AppStyles.stockPrice,
                ),
                const SizedBox(width: 16),
                Text(
                  '$symbol ${_stock.change.abs().toStringAsFixed(2)} (${_stock.changePercent.abs().toStringAsFixed(2)}%)',
                  style: AppStyles.stockChange.copyWith(color: color),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Price Chart Placeholder',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Key Information', style: AppStyles.sectionHeader),
                      const SizedBox(height: 16),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text('Market Cap'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  '\$${(_stock.marketCap / 1e9).toStringAsFixed(1)}B',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text('Volume'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  '${(_stock.volume / 1e6).toStringAsFixed(1)}M',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          // Add more rows
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
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
                          children: [
                            Text(
                              'Apple announces new product line',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Apple Inc. announced a new line of products set to launch next quarter...',
                              style: TextStyle(color: AppColors.textSecondary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Tech stocks surge',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}