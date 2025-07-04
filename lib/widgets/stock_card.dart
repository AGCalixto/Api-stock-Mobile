import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    this.textColor = Colors.white,
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
        onTap: () => Navigator.pushNamed(
          context,
          '/stock-detail',
          arguments: stock.symbol,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symbol
              AutoSizeText(
                stock.symbol,
                maxLines: 1,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: textColor),
              ),

              // Company Name
              AutoSizeText(
                stock.name,
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize:
                  Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
                  fontWeight:
                  Theme.of(context).textTheme.bodyMedium?.fontWeight,
                ),
              ),

              const SizedBox(height: 16),

              // Price and Change
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      '\$${stock.price.toStringAsFixed(2)}',
                      maxLines: 1,
                      minFontSize: 12,
                      style: AppStyles.stockPrice.copyWith(color: textColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AutoSizeText(
                    '$changeSymbol ${stock.changePercent.abs().toStringAsFixed(2)}%',
                    maxLines: 1,
                    minFontSize: 10,
                    style: TextStyle(
                      color: changeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Optional details
              if (showDetails) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Market Cap: \$${(stock.marketCap / 1e9).toStringAsFixed(1)}B',
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: textColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AutoSizeText(
                        'Volume: ${(stock.volume / 1e6).toStringAsFixed(1)}M',
                        maxLines: 1,
                        minFontSize: 10,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: textColor),
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
