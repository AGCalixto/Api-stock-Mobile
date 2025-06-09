import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';

class MarketCard extends StatelessWidget {
  final String market;
  final double index;
  final double change;
  final double changePercent;

  const MarketCard({
    super.key,
    required this.market,
    required this.index,
    required this.change,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUp = change >= 0;
    final Color color = isUp ? AppColors.upTrend : AppColors.downTrend;
    final String symbol = isUp ? '▲' : '▼';

    return Container(
      decoration: AppStyles.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(market, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  index.toStringAsFixed(2),
                  style: AppStyles.stockPrice,
                ),
                const SizedBox(width: 8),
                Text(
                  '$symbol ${change.abs().toStringAsFixed(2)} (${changePercent.abs().toStringAsFixed(2)}%)',
                  style: AppStyles.stockChange.copyWith(color: color),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stocks');
              },
              style: AppStyles.primaryButton,
              child: const Text('View All Stocks'),
            ),
          ],
        ),
      ),
    );
  }
}