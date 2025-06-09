class ApiConstants {
  static const baseUrl = 'https://api.marketstack.com/v1';
  static const apiKey = 'YOUR_API_KEY';

  static String stockEndpoint(String symbol) =>
      '$baseUrl/tickers/$symbol/eod?access_key=$apiKey';

  static String marketDataEndpoint(String exchange) =>
      '$baseUrl/eod?access_key=$apiKey&exchange=$exchange';

  static String searchEndpoint(String query) =>
      '$baseUrl/tickers?access_key=$apiKey&search=$query';
}