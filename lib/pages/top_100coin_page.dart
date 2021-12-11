import 'package:coin/pages/widget/widget_item.dart';
import 'package:flutter/material.dart';

import 'coin_responsitory.dart';

class Top100CoinPage extends StatefulWidget {
  Top100CoinPage({Key? key}) : super(key: key);

  @override
  _Top100CoinState createState() => _Top100CoinState();
}

class _Top100CoinState extends State<Top100CoinPage> {
  CoinResponsitory coinResponsitory = CoinResponsitory();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await coinResponsitory.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return WidgetItemList(CoinResponsitory.listCoinModel[index]);
      },
      itemCount: CoinResponsitory.listCoinModel.length,
    );
  }
}