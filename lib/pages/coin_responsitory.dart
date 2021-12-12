import 'dart:convert';

import 'package:coin/models/chart_model.dart';
import 'package:coin/models/coin_dao.dart';
import 'package:coin/models/coin_model.dart';
import 'package:coin/models/database.dart';
import 'package:dio/dio.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CoinResponsitory {
  static List<CoinModel> listCoinModel = List.empty();
  static CoinDao? coinDao;

  Future<void> initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder("appDb.db").build();
    coinDao = database.coinDao;
  }

  Future<void> getData() async {
    var dio = Dio();
    final response = (await dio.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    //final coinModel =  CoinModel.fromJson(response.data)
    listCoinModel = List<CoinModel>.from(
        (response.data as List).map((e) => CoinModel.fromJson(e)));
    print('getData::' + listCoinModel.toString());
  }

  Future<bool> checkFavor(CoinModel? coin) async {
    CoinModel? coinModel = await coinDao?.findCoinById(coin?.id ?? '0');
    if (coinModel != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<List<charts.Series<ChartModel, DateTime>>> getChart(
      String id, int hour) async {
    var dio = Dio();
    String from = (DateTime.now()
                .subtract(Duration(hours: hour))
                .toUtc()
                .millisecondsSinceEpoch /
            1000)
        .round()
        .toString();
    String to =
        (DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
    final reponse = await dio.get(
        "https://api.coingecko.com/api/v3/coins/$id/market_chart/range?vs_currency=usd&from=$from&to=$to");
    print("reponse::" + reponse.toString());
    List<ChartModel> listChart = [];
    await jsonDecode(reponse.toString())['prices'].forEach((element) {
      print("element::"+element.toString());
      listChart.add(ChartModel(element[1].toString(),
          DateTime.fromMillisecondsSinceEpoch(element[0])));
    });
    print("listChart::" + listChart.toString());

    return Future.value([
      charts.Series<ChartModel, DateTime>(
          id: "ChartCoin",
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          measureFn: (ChartModel chart, _) => num.parse(chart.price.toString()),
          domainFn: (ChartModel chart, _) => chart.dateTime ?? DateTime.now(),
          data: listChart)
    ]);
  }
}
