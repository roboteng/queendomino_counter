import 'package:flutter/material.dart';
import 'package:queendomino_counter/constants/constants.dart';

const String FUNC = 'func';
const String EDITABLE = 'editable';
const String ICON = 'icon';
const String SECOND = 'second';

Map<String, dynamic> getCategoryProperties(String category) {
  Map<String, dynamic> dict = {};
  if (category == kCoin) {
    dict[FUNC] = (int x, int y) => x ~/ 3;
    dict[EDITABLE] = false;
    dict[ICON] = Text('/');
    dict[SECOND] = 3;
  } else if (category == kPointsPTerritory) {
    dict[FUNC] = (int x, int y) => x * 2;
    dict[EDITABLE] = false;
    dict[ICON] = Text('*');
    dict[SECOND] = 2;
  } else if ([kTowers, kKnights].contains(category)) {
    dict[FUNC] = (int x, int y) => x * y * 2;
    dict[EDITABLE] = true;
    dict[ICON] = Text('* 2 *');
  } else {
    dict[FUNC] = (int x, int y) => x * y;
    dict[EDITABLE] = true;
    dict[ICON] = Text('*');
  }
  return dict;
}
