import 'package:floor/floor.dart';

@entity
class CoinModel {
  CoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCapRank,
    this.marketCapChangePercentage24h,

    this.atlDate,
    this.lastUpdated,});

  @override
  String toString() {
    return 'CoinModel{name: $name, image: $image, currentPrice: $currentPrice, marketCapRank: $marketCapRank, marketCapChangePercentage24h: $marketCapChangePercentage24h}';
  }

  CoinModel.fromJson(dynamic json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'].toString();
    marketCapRank = json['market_cap_rank'].toString();
    marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];

    atlDate = json['atl_date'];
    lastUpdated = json['last_updated'];
  }
  @primaryKey
  String? id;
  String? symbol;
  String? name;
  String? image;
  String? currentPrice;
  String? marketCapRank;
  double? marketCapChangePercentage24h;
  String? atlDate;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol'] = symbol;
    map['name'] = name;
    map['image'] = image;
    map['current_price'] = currentPrice;
    map['market_cap_rank'] = marketCapRank;
    map['atl_date'] = atlDate;
    map['last_updated'] = lastUpdated;
    return map;
  }

}