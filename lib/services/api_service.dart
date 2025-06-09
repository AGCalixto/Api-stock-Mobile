import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_frontend/constants/api_constants.dart';
import 'package:stock_frontend/models/stock.dart';

class ApiService {
  Future<List<Stock>> fetchMarketData(String exchange) async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));

    return [
      Stock(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: 172.35,
        change: 2.45,
        changePercent: 1.44,
        marketCap: 2.87e12,
        volume: 54.3e6,
        high: 182.94,
        low: 124.17,
        peRatio: 29.34,
      ),
      Stock(
        symbol: 'MSFT',
        name: 'Microsoft Corp.',
        price: 289.12,
        change: -1.23,
        changePercent: -0.42,
        marketCap: 2.19e12,
        volume: 32.1e6,
        high: 298.76,
        low: 245.12,
        peRatio: 34.12,
      ),
      // Add more stocks
    ];
  }

  Future<Stock> fetchStockDetails(String symbol) async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));

    return Stock(
      symbol: symbol,
      name: 'Apple Inc.',
      price: 172.35,
      change: 2.45,
      changePercent: 1.44,
      marketCap: 2.87e12,
      volume: 54.3e6,
      high: 182.94,
      low: 124.17,
      peRatio: 29.34,
    );
  }
}