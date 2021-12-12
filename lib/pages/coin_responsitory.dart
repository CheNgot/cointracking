import 'package:coin/models/coin_dao.dart';
import 'package:coin/models/coin_model.dart';
import 'package:coin/models/database.dart';
import 'package:dio/dio.dart';

class CoinResponsitory {
  static List<CoinModel> listCoinModel = List.empty();
  static CoinDao? coinDao;

  Future<void>initDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder("appDb.db").build();
    coinDao = database.coinDao;

}

  Future<void> getData() async {
    var dio = Dio();
    final response = (await dio.get('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    //final coinModel =  CoinModel.fromJson(response.data)
    listCoinModel = List<CoinModel>.from((response.data as List).map((e) => CoinModel.fromJson(e)));
    print('getData::'+ listCoinModel.toString());
  }

  Future<bool> checkFavor(CoinModel? coin) async{
    CoinModel? coinModel =await coinDao?.findCoinById(coin?.id??'0');
    if(coinModel!=null){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }
}