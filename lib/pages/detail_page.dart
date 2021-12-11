import 'package:coin/models/coin_model.dart';
import 'package:coin/utils/dimens.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this.item, {Key? key}) : super(key: key);
  CoinModel? item;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavoriteCheck = true;

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
    isFavoriteCheck = !isFavoriteCheck;
    setState(() {});
  }
}
