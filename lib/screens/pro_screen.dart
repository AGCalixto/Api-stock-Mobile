import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';

class ProScreen extends StatelessWidget {
  const ProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Pro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Upgrade to StockMarket Pro',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Get advanced features and insights to maximize your investment potential',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildPlanCard(
                    title: 'Basic',
                    price: '\$0',
                    features: [
                      'Real-time stock data',
                      'Basic portfolio tracking',
                      'Standard news updates',
                    ],
                    isFeatured: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPlanCard(
                    title: 'Pro',
                    price: '\$9.99',
                    features: [
                      'All Basic features',
                      'Advanced charting tools',
                      'Real-time alerts',
                      'Premium research reports',
                      'Technical indicators',
                      'Priority customer support',
                    ],
                    isFeatured: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPlanCard(
                    title: 'Premium',
                    price: '\$19.99',
                    features: [
                      'All Pro features',
                      'AI-powered predictions',
                      'Customizable dashboards',
                      'Exclusive webinars',
                      'Dedicated account manager',
                      '24/7 premium support',
                    ],
                    isFeatured: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Frequently Asked Questions', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('How do I cancel my subscription?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'You can cancel your subscription at any time from your account settings. Your access will continue until the end of your current billing period.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Can I switch plans later?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Yes, you can upgrade or downgrade your plan at any time. The changes will be applied at the start of your next billing cycle.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Do you offer discounts for students?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Yes, we offer a 50% discount for students. Please contact our support team with proof of enrollment to get your discount.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required List<String> features,
    bool isFeatured = false,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isFeatured ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      elevation: isFeatured ? 4 : 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
              price,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text('per month', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            const Divider(),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(feature)),
                ],
              ),
            )).toList(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isFeatured ? AppColors.primary : Colors.transparent,
                foregroundColor: isFeatured ? AppColors.background : AppColors.primary,
                side: BorderSide(
                  color: isFeatured ? Colors.transparent : AppColors.primary,
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(isFeatured ? 'Get Started' : 'Choose Plan'),
            ),
          ],
        ),
      ),
    );
  }
}