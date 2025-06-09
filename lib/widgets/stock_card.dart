import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final bool showDetails;

  const StockCard({
    super.key,
    required this.stock,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUp = stock.change >= 0;
    final Color color = isUp ? AppColors.upTrend : AppColors.downTrend;
    final String symbol = isUp ? '▲' : '▼';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/stock-detail',
            arguments: stock.symbol,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stock.symbol, style: Theme.of(context).textTheme.headlineSmall),
              Text(stock.name, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              )),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${stock.price.toStringAsFixed(2)}',
                    style: AppStyles.stockPrice,
                  ),
                  Text(
                    '$symbol ${stock.changePercent.abs().toStringAsFixed(2)}%',
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (showDetails) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Market Cap: \$${(stock.marketCap / 1e9).toStringAsFixed(1)}B',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text('Volume: ${(stock.volume / 1e6).toStringAsFixed(1)}M',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}