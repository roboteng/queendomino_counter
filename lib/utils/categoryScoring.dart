import 'package:flutter/material.dart';
import 'package:queendomino_counter/domain/entities/categories.dart';

ScoringInfo getCategoryProperties(Category category) {
  return category.getProperties();
}

class ScoringInfo {
  final int Function(int, int) calculate;
  final bool editable;
  final Widget icon;
  final int isSecondSlotEditable;

  ScoringInfo(
      this.calculate, this.editable, this.icon, this.isSecondSlotEditable);
}
