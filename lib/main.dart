import 'package:coin/pages/coin_responsitory.dart';
import 'package:coin/pages/favourite_page.dart';
import 'package:coin/pages/search_coin_page.dart';
import 'package:coin/pages/top_100coin_page.dart';
import 'package:coin/pages/top_5coin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CoinResponsitory coinResponsitory = CoinResponsitory();
  await coinResponsitory.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final listTitle = const [
    'List 100 coin top',
    'List 5 coin top',
    'Search coin',
    'Favourite coin',
  ];

  final listWidgetHome = [
    Top100CoinPage(), Top5CoinPage(), SearchCoinPage(), FavouritePage()
  ];

  void onTapBottom(int indexItem) {
    setState(() {
      index = indexItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text(listTitle[index])),
      ),
      body: listWidgetHome[index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Top 100',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Top 5 coin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search coin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite coin',
          ),
        ],
        currentIndex: index,
        selectedIconTheme: const IconThemeData(color: Colors.orangeAccent),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.black,
        onTap: onTapBottom,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}