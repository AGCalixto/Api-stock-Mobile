import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/models/stock.dart';
import 'package:stock_frontend/services/api_service.dart';
import 'package:stock_frontend/widgets/stock_card.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  final ApiService _apiService = ApiService();
  List<Stock> _stocks = [];
  bool _isLoading = true;

  final List<String> _intervalOptions = ['1 Day', '1 Week', '1 Month', '3 Months', '1 Year'];
  final List<String> _currencyOptions = ['USD', 'EUR', 'GBP', 'JPY'];

  String _selectedInterval = '1 Month';
  String _selectedCurrency = 'USD';
  String _searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStocks();
  }

  Future<void> _fetchStocks() async {
    setState(() => _isLoading = true);
    final stocks = await _apiService.fetchMarketData('NASDAQ');
    setState(() {
      _stocks = stocks;
      _isLoading = false;
    });
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.secondary),
      ),
    );
  }

  List<Stock> _filterStocks() {
    if (_searchQuery.isEmpty) return _stocks;
    return _stocks
        .where((stock) =>
    stock.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        stock.symbol.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Stocks'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                const Text('Market Stocks', style: AppStyles.sectionHeader),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 120,
                      child: DropdownButtonFormField<String>(
                        value: _selectedInterval,
                        dropdownColor: const Color(0xFF0F1820),
                        style: const TextStyle(color: Colors.white),
                        items: _intervalOptions
                            .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: const TextStyle(color: Colors.white))))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedInterval = value;
                            });
                          }
                        },
                        decoration: _dropdownDecoration(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 100,
                      child: DropdownButtonFormField<String>(
                        value: _selectedCurrency,
                        dropdownColor: const Color(0xFF0F1820),
                        style: const TextStyle(color: Colors.white),
                        items: _currencyOptions
                            .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: const TextStyle(color: Colors.white))))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCurrency = value;
                            });
                          }
                        },
                        decoration: _dropdownDecoration(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Color(0xFF94A3B8)),
              decoration: InputDecoration(
                hintText: 'Search stocks...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.secondary),
                ),
                suffixIcon: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Search'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filterStocks().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: StockCard(stock: _filterStocks()[index], showDetails: true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
