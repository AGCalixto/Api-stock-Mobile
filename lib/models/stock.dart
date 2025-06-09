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
    return Stock(
      symbol: json['symbol'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      change: double.parse(json['change'].toString()),
      changePercent: double.parse(json['changePercent'].toString()),
      marketCap: double.parse(json['marketCap'].toString()),
      volume: double.parse(json['volume'].toString()),
      high: double.parse(json['high'].toString()),
      low: double.parse(json['low'].toString()),
      peRatio: double.parse(json['peRatio'].toString()),
    );
  }
}