import 'package:flutter/material.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ScoringScreenDisplay extends StatelessWidget {
  final ScoringScreenViewmodel model;

  const ScoringScreenDisplay(this.model, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StickyHeadersTable(
        columnsLength: model.columnTitles.length,
        rowsLength: model.rowTitles.length + 1, // one more for total
        columnsTitleBuilder: (x) => Text(model.columnTitles[x]),
        rowsTitleBuilder: (y) =>
            Text(y == model.rowTitles.length ? 'Total' : model.rowTitles[y]),
        contentCellBuilder: (x, y) {
          if (y == model.rowTitles.length) {
            return Text(model.footerTitles[x]);
          }
          return model.cells[y][x];
        },
      ),
    );
  }
}
