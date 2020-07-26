import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

ScoringBloc _bloc = ScoringBloc();

class ScoringScreen extends StatefulWidget {
  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  List<String> players = ['Trevor', 'Karen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QueenDomino Counter'),
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
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<ScoringBloc, ScoringDetails>(
            bloc: _bloc,
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
                        onChange: (newVal) {
                          _bloc.add(
                            ScoringEvent(
                              type: kCategories[row],
                              base: int.parse(newVal),
                              playerId: column,
                            ),
                          );
                        },
                      );
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}

class ScoringUnit extends StatefulWidget {
  final Function onChange;

  ScoringUnit({Key key, this.onChange}) : super(key: key);
  @override
  _ScoringUnitState createState() => _ScoringUnitState();
}

class _ScoringUnitState extends State<ScoringUnit> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(
      () {
        {
          if (_controller.text != '') {
            widget.onChange(_controller.text);
          } else {
            widget.onChange('0');
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 96,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.number,
          controller: _controller,
        ),
      ),
    );
  }
}
