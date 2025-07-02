import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';

class ProScreen extends StatelessWidget {
  const ProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Pro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _PlanCard(
                  title: 'Basic',
                  price: '\$0',
                  features: [
                    'Real-time stock data',
                    'Basic portfolio tracking',
                    'Standard news updates',
                  ],
                  isFeatured: false,
                ),
                _PlanCard(
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
                _PlanCard(
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
              ],
            ),
            const SizedBox(height: 32),
            const Text('Frequently Asked Questions', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            const _FaqItem(
              question: 'How do I cancel my subscription?',
              answer:
              'You can cancel your subscription at any time from your account settings. Your access will continue until the end of your current billing period.',
            ),
            const _FaqItem(
              question: 'Can I switch plans later?',
              answer:
              'Yes, you can upgrade or downgrade your plan at any time. The changes will be applied at the start of your next billing cycle.',
            ),
            const _FaqItem(
              question: 'Do you offer discounts for students?',
              answer:
              'Yes, we offer a 50% discount for students. Please contact our support team with proof of enrollment to get your discount.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isFeatured;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
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
              Text(price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text('per month', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              const Divider(),
              ...features.map(
                    (feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                ),
              ),
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
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
