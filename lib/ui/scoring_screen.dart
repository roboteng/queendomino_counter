import 'package:flutter/material.dart';
import 'package:queendomino_counter/screens/scoring_screen_presenter.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';

class ScoringScreen extends StatefulWidget {
  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  var model = ScoringScreenViewmodel();
  @override
  void initState() {
    model = ScoringScreenViewmodel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScoringScreenPresenter(model);
  }
}
