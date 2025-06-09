import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final double accountBalance;
  final double portfolioValue;
  final double portfolioChange;
  final double portfolioChangePercent;
  final double dailyChange;
  final double dailyChangePercent;
  final double totalGainLoss;
  final double totalGainLossPercent;

  const PortfolioSummaryCard({
    super.key,
    required this.accountBalance,
    required this.portfolioValue,
    required this.portfolioChange,
    required this.portfolioChangePercent,
    required this.dailyChange,
    required this.dailyChangePercent,
    required this.totalGainLoss,
    required this.totalGainLossPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF20262B), Color(0xFF1a2025)],
        ),
        border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Account Balance', style: TextStyle(color: AppColors.textSecondary)),
                Text('\$$accountBalance.toStringAsFixed(2)}', style: AppStyles.portfolioValue),
              ],
            ),
            const Divider(color: AppColors.accent, height: 32),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Portfolio Value', style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text('\$$portfolioValue.toStringAsFixed(2)}', style: AppStyles.portfolioValue),
                      const SizedBox(height: 4),
                      Text(
                        '▲ \$$portfolioChange.toStringAsFixed(2)} (${portfolioChangePercent.toStringAsFixed(2)}%)',
                        style: const TextStyle(color: AppColors.upTrend, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Today\'s Change', style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text('\$$dailyChange.toStringAsFixed(2)}', style: AppStyles.portfolioValue),
                      const SizedBox(height: 4),
                      Text(
                        '▲ ${dailyChangePercent.toStringAsFixed(2)}%',
                        style: const TextStyle(color: AppColors.upTrend, fontWeight: FontWeight.bold),
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