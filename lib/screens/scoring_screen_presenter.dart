import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';
import 'package:queendomino_counter/ui/scoring_screen_display.dart';
import 'package:queendomino_counter/ui/scoring_screen_viewmodel_generator.dart';
import 'package:queendomino_counter/widgets/app_drawer.dart';

class ScoringScreenPresenter extends StatefulWidget {
  @override
  _ScoringScreenPresenterState createState() => _ScoringScreenPresenterState();
}

class _ScoringScreenPresenterState extends State<ScoringScreenPresenter> {
  List<String> playerNames = ['Trevor', 'Karen', 'Franklin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'QueenDomino Counter',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              List<String> newPlayerNames = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SettingsModal(
                  players: playerNames,
                ),
              );
              if (newPlayerNames != null) {
                setState(() {
                  playerNames = newPlayerNames;
                });
              }
            },
            icon: Icon(Icons.person_add_alt),
          )
        ],
      ),
      body: BlocBuilder<ScoringBloc, List<PlayerScore>>(
        builder: (context, scores) => ScoringScreenDisplay(
          ScoringScreenViewmodelGenerator().generate(scores),
        ),
      ),
    );
  }
}
