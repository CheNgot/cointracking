import 'package:floor/floor.dart';

import 'coin_model.dart';
@dao
abstract class CoinDao{
  @Query('SELECT * FROM CoinModel')
  Future<List<CoinModel>> listAllCoin();

  @Query('SELECT * FROM CoinModel WHERE id = :id')
  Future<CoinModel?> findCoinById(String id);

  @insert
  Future<void> insertCoin(CoinModel coinModel);

  @delete
  Future<void> removeCoin(CoinModel coinModel);
}