// To parse this JSON data, do
//
//     final stocksList = stocksListFromJson(jsonString);

import 'dart:convert';

List<StocksList> stocksListFromJson(String str) =>
    List<StocksList>.from(json.decode(str).map((x) => StocksList.fromJson(x)));

String stocksListToJson(List<StocksList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StocksList {
  StocksList({
    required this.name,
    required this.price,
    required this.high,
    required this.low,
    required this.image,
    required this.symbol,
    required this.status,
  });

  String name;
  String image;
  String symbol;
  double status;
  int price;
  int high;
  int low;

  factory StocksList.fromJson(Map<String, dynamic> json) => StocksList(
        name: json["name"],
        price: json["price"],
        high: json["high"],
        low: json["low"],
        image: json["image"],
        symbol: json["symbol"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "high": high,
        "low": low,
        "image": image,
        "symbol": symbol,
        "status": status,
      };
}
