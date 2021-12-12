import 'package:coin/models/coin_model.dart';
import 'package:coin/pages/coin_responsitory.dart';
import 'package:coin/utils/dimens.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this.item, {Key? key}) : super(key: key);
  CoinModel? item;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavoriteCheck = false;
  CoinResponsitory coinResponsitory = CoinResponsitory();

  @override
  void initState() {
    checkFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "Detail",
          style: TextStyle(fontSize: 30.t),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.item?.name ?? '',
              style: TextStyle(fontSize: 25.t),
            ),
            IconButton(
                onPressed: onClickFavorite,
                icon: Icon(
                  isFavoriteCheck ? Icons.favorite : Icons.favorite_border,
                  size: 30.w,
                )),
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

  void checkFavorite() {
    coinResponsitory.checkFavor(widget.item).then((isFavorite) {
      if (isFavorite) {
        print("isFavorite::" + isFavorite.toString());

        isFavoriteCheck = true;
        print("isFavoriteCheck::" + isFavoriteCheck.toString());

        setState(() {});
      } else {
        print("isFavorite::" + isFavorite.toString());
        isFavoriteCheck = false;
        print("isFavoriteCheck::" + isFavoriteCheck.toString());

        setState(() {});
      }
    });
  }
}
