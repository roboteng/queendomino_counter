import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ModeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MathMode _math;
  GameMode _game;
  ModeProvider(
      {MathMode math = MathMode.easy, GameMode game = GameMode.kingdomino})
      : this._math = math,
        this._game = game;

  MathMode get math => _math;
  set math(MathMode m) {
    _math = m;
    notifyListeners();
  }

  GameMode get game => _game;
  set game(GameMode m) {
    _game = m;
    notifyListeners();
  }
}

enum MathMode {
  easy,
  math,
}

enum GameMode {
  kingdomino,
  queendomino,
}
