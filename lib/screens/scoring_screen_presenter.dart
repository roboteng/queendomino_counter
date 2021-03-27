import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';
import 'package:queendomino_counter/ui/scoring_screen_display.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:queendomino_counter/widgets/app_drawer.dart';
import 'package:queendomino_counter/widgets/scoringUnit.dart';

class ScoringScreenPresenter extends StatefulWidget {
  @override
  _ScoringScreenPresenterState createState() => _ScoringScreenPresenterState();
}

class _ScoringScreenPresenterState extends State<ScoringScreenPresenter> {
  List<String> playerNames = ['Trevor', 'Karen'];

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
      body: BlocBuilder<ScoringBloc, ScoringDetails>(
        builder: (context, details) => ScoringScreenDisplay(
          ScoringScreenViewmodel(
            columnTitles: playerNames,
            rowTitles: categories.map((c) => c.shortString).toList(),
            footerTitles: List.generate(playerNames.length, (i) => i)
                .map((e) => details.total(e).toString())
                .toList(),
            cells: categories
                .map(
                  (category) => List.generate(
                    playerNames.length,
                    (playerIndex) => ScoringUnit(
                      category: category,
                      onChange: (newVal) {
                        BlocProvider.of<ScoringBloc>(context).add(
                          ScoringEvent(
                            category: category,
                            base: newVal,
                            playerId: playerIndex,
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
