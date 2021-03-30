class ScoringScreenViewmodel {
  final List<String> columnTitles;
  final List<String> rowTitles;
  final List<String> footerTitles;
  final List<List<String>> cellLabels; //stored as [y][x]
  final List<List<Function()>> cellOnTap;

  ScoringScreenViewmodel({
    this.columnTitles,
    this.rowTitles,
    this.footerTitles,
    this.cellLabels,
    this.cellOnTap,
  });
}
