import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/services/api_service.dart';
import 'package:stock_frontend/services/geolocation_service.dart';
import 'package:stock_frontend/widgets/market_card.dart';
import 'package:stock_frontend/widgets/stock_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final GeolocationService _geolocationService = GeolocationService();
  String _location = 'Detecting your location...';
  List<Stock> _topStocks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);

    final location = await _geolocationService.getCurrentLocation();
    final stocks = await _apiService.fetchMarketData('NASDAQ');

    setState(() {
      _location = 'Showing data for: $location';
      _topStocks = stocks;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockMarket', style: TextStyle(color: AppColors.primary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withOpacity(0.9),
                    AppColors.background.withOpacity(0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Real-time Market Insights',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Track stocks based on your location and market trends with our powerful analytics platform',
                      style: TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/stocks'),
                        style: AppStyles.primaryButton,
                        child: const Text('Explore Markets'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/auth'),
                        style: AppStyles.outlineButton,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Market Overview
            Text('Current Market Overview', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            MarketCard(
              market: 'NASDAQ',
              index: 14234.56,
              change: 234.12,
              changePercent: 1.67,
            ),
            const SizedBox(height: 24),

            // Top Stocks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Stocks', style: AppStyles.sectionHeader),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/stocks'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: _topStocks.length,
              itemBuilder: (context, index) {
                return StockCard(stock: _topStocks[index]);
              },
            ),
            const SizedBox(height: 24),

            // Location Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(_location, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  TextButton(
                    onPressed: _fetchData,
                    child: const Text('Change', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stocks'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/stocks');
          if (index == 2) Navigator.pushNamed(context, '/portfolio');
        },
      ),
    );
  }
}