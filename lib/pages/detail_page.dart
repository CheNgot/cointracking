import 'package:coin/models/chart_model.dart';
import 'package:coin/models/coin_model.dart';
import 'package:coin/pages/coin_responsitory.dart';
import 'package:coin/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DetailPage extends StatefulWidget {
  DetailPage(this.item, {Key? key}) : super(key: key);
  CoinModel? item;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavoriteCheck = false;
  CoinResponsitory coinResponsitory = CoinResponsitory();
  List<charts.Series<ChartModel, DateTime>> historyCoin = List.empty();
  int type = 0;

  @override
  void initState() {
    syncData();
    // coinResponsitory.getChart(widget.item?.id ?? '', 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          widget.item?.name ?? '',
          style: TextStyle(fontSize: 35.t),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add to favorite",
                  style: TextStyle(fontSize: 20.t),
                ),
                IconButton(
                    onPressed: onClickFavorite,
                    icon: Icon(
                      isFavoriteCheck ? Icons.favorite : Icons.favorite_border,
                      size: 30.w,
                    ))
              ],
            ),
            Expanded(
              child: charts.TimeSeriesChart(
                historyCoin,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => syncHistory(8),
                    child: Text("8h",
                        style: TextStyle(
                            color: type == 8 ? Colors.red : Colors.blue))),
                TextButton(
                  onPressed: () => syncHistory(168),
                  child: Text(
                    "1W",
                    style: TextStyle(
                        color: type == 168 ? Colors.red : Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => syncHistory(731),
                  child: Text(
                    "1M",
                    style: TextStyle(
                        color: type == 731 ? Colors.red : Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => syncHistory(4381),
                  child: Text(
                    "6M",
                    style: TextStyle(
                        color: type == 4381 ? Colors.red : Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => syncHistory(8766),
                  child: Text(
                    "1Y",
                    style: TextStyle(
                        color: type == 8766 ? Colors.red : Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onClickFavorite() {
    print("clickFavo");
    coinResponsitory.checkFavor(widget.item).then((isFavorite) {
      if (isFavorite) {
        print("isFavorite::" + isFavorite.toString());

        CoinResponsitory.coinDao?.removeCoin(widget.item!);
        isFavoriteCheck = false;
        print("isFavoriteCheck::" + isFavoriteCheck.toString());

        setState(() {});
      } else {
        print("isFavorite::" + isFavorite.toString());
        CoinResponsitory.coinDao?.insertCoin(widget.item!);
        isFavoriteCheck = true;
        print("isFavoriteCheck::" + isFavoriteCheck.toString());

        setState(() {});
      }
    });
  }

  void syncData() async {
    coinResponsitory.checkFavor(widget.item).then((isFavorite) {
      isFavoriteCheck = isFavorite;
      syncHistory(8);
    });
  }

  void syncHistory(int hour) async {
    type = hour;
    historyCoin = await coinResponsitory.getChart(widget.item?.id ?? '', hour);
    setState(() {});
  }
}
