import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_frontend/constants/api_constants.dart';
import 'package:stock_frontend/models/stock.dart';

class ApiService {
  /// Obtiene datos del mercado para una lista fija de símbolos
  Future<List<Stock>> fetchMarketData(String exchange) async {
    final symbols = ['AAPL', 'MSFT', 'GOOGL', 'META', 'TSLA'];

    final url = Uri.parse(ApiConstants.marketDataEndpoint(symbols));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['data'];

      return results.map((item) {
        final symbol = item['symbol'] ?? '';
        final name = symbol;
        final close = item['close']?.toDouble() ?? 0.0;
        final open = item['open']?.toDouble() ?? close;
        final change = close - open;
        final changePercent = open != 0 ? (change / open) * 100 : 0;

        return Stock(
          symbol: symbol,
          name: name,
          price: close,
          change: change,
          changePercent: changePercent,
          marketCap: 0.0,
          volume: item['volume']?.toDouble() ?? 0.0,
          high: item['high']?.toDouble() ?? 0.0,
          low: item['low']?.toDouble() ?? 0.0,
          peRatio: 0.0,
        );
      }).toList();
    } else {
      throw Exception('Error loading market data');
    }
  }

  /// Obtiene detalles actuales de una acción específica
  Future<Stock> fetchStockDetails(String symbol) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/eod?access_key=${ApiConstants.apiKey}&symbols=$symbol&limit=1',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final item = data['data'][0];

      final double close = item['close']?.toDouble() ?? 0.0;
      final double open = item['open']?.toDouble() ?? close;
      final double change = close - open;
      final double changePercent = open != 0 ? (change / open) * 100 : 0;

      return Stock(
        symbol: symbol,
        name: symbol,
        price: close,
        change: change,
        changePercent: changePercent,
        marketCap: 0.0,
        volume: item['volume']?.toDouble() ?? 0.0,
        high: item['high']?.toDouble() ?? 0.0,
        low: item['low']?.toDouble() ?? 0.0,
        peRatio: 0.0,
      );
    } else {
      throw Exception('Failed to load stock details');
    }
  }

  /// Obtiene historial de precios para la acción (últimos 30 días)
  Future<List<double>> fetchPriceHistory(String symbol) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/eod?access_key=${ApiConstants.apiKey}&symbols=$symbol&limit=30&sort=DESC',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['data'];

      return results
          .map<double>((item) => item['close']?.toDouble() ?? 0.0)
          .toList()
          .reversed
          .toList(); // Para que el gráfico se muestre en orden cronológico
    } else {
      throw Exception('Failed to load price history');
    }
  }
}
