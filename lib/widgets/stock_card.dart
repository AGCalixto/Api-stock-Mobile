import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final bool showDetails;
  final Color textColor;

  const StockCard({
    super.key,
    required this.stock,
    this.showDetails = false,
    this.textColor = Colors.white
  });

  bool get isUp => stock.change >= 0;
  Color get changeColor => isUp ? AppColors.upTrend : AppColors.downTrend;
  String get changeSymbol => isUp ? '▲' : '▼';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/stock-detail', arguments: stock.symbol),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stock.symbol, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: textColor)),
              Text(
                stock.name,
                style: TextStyle(
                  color:AppColors.textSecondary,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${stock.price.toStringAsFixed(2)}',
                      style: AppStyles.stockPrice.copyWith(color: textColor)),
                  Text(
                    '$changeSymbol ${stock.changePercent.abs().toStringAsFixed(2)}%',
                    style: TextStyle(color: changeColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (showDetails) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Market Cap: \$${(stock.marketCap / 1e9).toStringAsFixed(1)}B',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Volume: ${(stock.volume / 1e6).toStringAsFixed(1)}M',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
