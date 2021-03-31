import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';
import 'package:queendomino_counter/ui/scoring_modal.dart';
import 'package:queendomino_counter/ui/scoring_screen_display.dart';
import 'package:queendomino_counter/ui/scoring_screen_viewmodel_generator.dart';
import 'package:queendomino_counter/utils/scoring.dart';
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
            icon: Icon(Icons.person_add_alt, semanticLabel: "Change Players"),
            onPressed: () async {
              List<ScoringEvent> events = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => EditPlayersModal(
                  players: BlocProvider.of<ScoringBloc>(context, listen: false)
                      .state
                      .map((e) => e.player)
                      .toList(),
                ),
              );
              events?.forEach((event) {
                BlocProvider.of<ScoringBloc>(context, listen: false).add(event);
              });
            },
          )
        ],
      ),
      body: BlocBuilder<ScoringBloc, List<PlayerScore>>(
        builder: (context, scores) => ScoringScreenDisplay(
          ScoringScreenViewmodelGenerator().generate(
            scores,
            (category, score) => () async {
              final int newValue = await showDialog(
                  context: context,
                  builder: (context) {
                    return ScoringModal(
                      category: category,
                      player: score.player,
                      initialValue: score.details.details[category] ?? 0,
                    );
                  });
              if (newValue != null) {
                BlocProvider.of<ScoringBloc>(context, listen: false)
                    .add(UpdateScoreEvent(score.player, category, newValue));
              }
            },
          ),
        ),
      ),
    );
  }
}
