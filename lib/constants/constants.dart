import 'package:queendomino_counter/domain/entities/categories.dart';

final String kCoin = 'Coin';
final String kWheat = 'Wheat';
final String kForest = 'Forest';
final String kWater = 'Water';
final String kPasture = 'Pasture';
final String kMarsh = 'Marsh';
final String kMines = 'Mines';
final String kBuildings = 'Buildings';
final String kPointsPTerritory = 'Points per\nTerritory';
final String kTowers = 'Towers';
final String kKnights = 'Knights';
final String kPoints = 'Points';

final List<Category> categories = [
  Coin(),
  Wheat(),
  Forest(),
  Water(),
  Pasture(),
  Marsh(),
  Mines(),
  Buildings(),
  PointsPerTerritory(),
  Towers(),
  Knights(),
  PointsForBuildings(),
];
