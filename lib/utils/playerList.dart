class DeletablePlayer {
  bool _isDeleted;
  String name;

  DeletablePlayer(this.name, {isDeleted}) : _isDeleted = isDeleted ?? false;

  bool get isDeleted => _isDeleted;

  void delete() {
    _isDeleted = true;
  }
}

List<String> getPlayers(List<DeletablePlayer> players) {
  List<DeletablePlayer> validPlayers =
      players.where((element) => !element.isDeleted).toList();
  return validPlayers
      .fold([], (previousValue, element) => previousValue + [element.name]);
}

String getNextPlayerName(List<String> players) {
  int i = 0;
  while (true) {
    i++;
    if (!players.contains(getPlayerNameFromIndex(i))) {
      return getPlayerNameFromIndex(i);
    }
  }
}

String getPlayerNameFromIndex(int i) {
  return 'Player $i';
}
