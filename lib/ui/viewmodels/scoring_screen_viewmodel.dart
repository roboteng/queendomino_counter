import 'package:flutter/material.dart';

class ScoringScreenViewmodel {
  final List<String> columnTitles;
  final List<String> rowTitles;
  final List<String> footerTitles;
  final List<List<Widget>> cells; // cells[y][x]

  ScoringScreenViewmodel({
    this.columnTitles,
    this.rowTitles,
    this.footerTitles,
    this.cells,
  });
}
