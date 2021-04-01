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
