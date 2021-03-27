import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:queendomino_counter/widgets/app_drawer.dart';
import 'package:queendomino_counter/widgets/scoringUnit.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ScoringScreen extends StatefulWidget {
  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  List<String> players = ['Trevor', 'Karen'];

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
              List<String> playerNames = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SettingsModal(
                  players: players,
                ),
              );
              if (playerNames != null) {
                setState(() {
                  this.players = playerNames;
                });
              }
            },
            icon: Icon(Icons.person_add_alt),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<ScoringBloc, ScoringDetails>(
            builder: (context, data) {
              ScoringDetails details = data;
              return StickyHeadersTable(
                columnsLength: players.length,
                rowsLength: kCategories.length + 1, // one more for total
                columnsTitleBuilder: (j) => Text(players[j]),
                rowsTitleBuilder: (i) {
                  return Text(
                      i == kCategories.length ? 'Total' : kCategories[i]);
                },
                contentCellBuilder: (column, row) {
                  if (row == kCategories.length) {
                    return Text(details.total(column).toString());
                  } else {
                    return ScoringUnit(
                      title: kCategories[row],
                      onChange: (newVal) {
                        BlocProvider.of<ScoringBloc>(context).add(
                          ScoringEvent(
                            type: kCategories[row],
                            base: newVal,
                            playerId: column,
                          ),
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
