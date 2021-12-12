import 'package:coin/models/coin_model.dart';
import 'package:coin/pages/coin_responsitory.dart';
import 'package:coin/pages/widget/widget_item.dart';
import 'package:flutter/cupertino.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<CoinModel> listCoinFavorite =[];
  CoinResponsitory coinResponsitory = CoinResponsitory();
  @override
  void initState() {
    getListFavorite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return WidgetItemList(listCoinFavorite[index]);
      },
      itemCount: listCoinFavorite.length,
    );
  }

  void getListFavorite() async {
  listCoinFavorite= await CoinResponsitory.coinDao?.listAllCoin() as List<CoinModel>;
  setState(() {

  });
  }
}