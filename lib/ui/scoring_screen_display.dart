import 'package:flutter/material.dart';
import 'package:queendomino_counter/screens/test_page.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';

class ScoringScreenDisplay extends StatelessWidget {
  final ScoringScreenViewmodel model;

  const ScoringScreenDisplay(this.model, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DynamicTable(
        columnsLength: model.columnTitles.length,
        rowsLength: model.rowTitles.length, // one more for total
        columnsTitleBuilder: (x) => Text(model.columnTitles[x]),
        rowsTitleBuilder: (y) =>
            Text(y == model.rowTitles.length ? 'Total' : model.rowTitles[y]),
        contentCellBuilder: (x, y) {
          return OutlinedButton(
            onPressed: model.cellOnTap[y][x],
            child: Text(
              model.cellLabels[y][x],
              semanticsLabel:
                  "${model.cellLabels[y][x]} ${model.rowTitles[y]} for ${model.columnTitles[x]}",
            ),
          );
        },
        footerBuilder: (x) {
          return Semantics(
            child: Text(
              model.footerTitles[x],
              semanticsLabel:
                  "${model.footerTitles[x]} for ${model.columnTitles[x]}",
            ),
          );
        },
        southWestTitle: Text('Total'),
      ),
    );
  }
}
