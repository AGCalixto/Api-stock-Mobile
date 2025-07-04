class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final double marketCap;
  final double volume;
  final double high;
  final double low;
  final double peRatio;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.marketCap,
    required this.volume,
    required this.high,
    required this.low,
    required this.peRatio,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    double _parseDouble(dynamic value) =>
        double.tryParse(value?.toString() ?? '') ?? 0.0;

    return Stock(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      price: _parseDouble(json['price']),
      change: _parseDouble(json['change']),
      changePercent: _parseDouble(json['changePercent']),
      marketCap: _parseDouble(json['marketCap']),
      volume: _parseDouble(json['volume']),
      high: _parseDouble(json['high']),
      low: _parseDouble(json['low']),
      peRatio: _parseDouble(json['peRatio']),
    );
  }

  @override
  String toString() {
    return 'Stock(symbol: $symbol, price: $price, change: $change%)';
  }
}
