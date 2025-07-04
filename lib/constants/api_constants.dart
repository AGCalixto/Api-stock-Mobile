class ApiConstants {
  static const baseUrl = 'http://api.marketstack.com/v1';
  static const apiKey = '37c70825814c0b65e6a33ae10c48ba95';

  static String stockEndpoint(String symbol) =>
      '$baseUrl/eod?access_key=$apiKey&symbols=$symbol&limit=30';

  static String marketDataEndpoint(List<String> symbols) =>
      '$baseUrl/eod?access_key=$apiKey&symbols=${symbols.join(",")}';

  static String searchEndpoint(String query) =>
      '$baseUrl/tickers?access_key=$apiKey&search=$query';
}