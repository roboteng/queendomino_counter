import 'package:flutter/material.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';

abstract class Category {
  ScoringInfo getProperties();
  String get shortString;

  @override
  bool operator ==(Object other) {
    return super.runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => this.runtimeType.hashCode;
}

class Coin extends Category {
  @override
  ScoringInfo getProperties() {
    return ScoringInfo((int x, int y) => x ~/ 3, false, Text('/'), 3);
  }

  String get shortString => kCoin;
}

class PointsPerTerritory extends Category {
  @override
  ScoringInfo getProperties() {
    return ScoringInfo((int x, int y) => x * 2, false, Text('*'), 2);
  }

  String get shortString => kPointsPTerritory;
}

class Towers extends Category {
  @override
  ScoringInfo getProperties() {
    return ScoringInfo((int x, int y) => x * y * 2, true, Text('* 2 *'), null);
  }

  String get shortString => kTowers;
}

class Knights extends Category {
  @override
  ScoringInfo getProperties() {
    return ScoringInfo((int x, int y) => x * y * 2, true, Text('* 2 *'), null);
  }

  String get shortString => kKnights;
}

abstract class Territory extends Category {
  @override
  ScoringInfo getProperties() {
    return ScoringInfo((int x, int y) => x * y, true, Text('*'), null);
  }
}

class Wheat extends Territory {
  String get shortString => kWheat;
}

class Forest extends Territory {
  String get shortString => kForest;
}

class Water extends Territory {
  String get shortString => kWater;
}

class Pasture extends Territory {
  String get shortString => kPasture;
}

class Marsh extends Territory {
  String get shortString => kMarsh;
}

class Mines extends Territory {
  String get shortString => kMines;
}

class Buildings extends Territory {
  String get shortString => kBuildings;
}

class PointsForBuildings extends Territory {
  String get shortString => kPoints;
}
