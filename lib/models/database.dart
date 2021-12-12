// database.dart

// required package imports
import 'dart:async';
import 'package:coin/models/coin_dao.dart';
import 'package:coin/models/coin_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;



part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CoinModel])
abstract class AppDatabase extends FloorDatabase {
  CoinDao get coinDao;
}