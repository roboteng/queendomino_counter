import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/screens/settingsModal.dart';

ScoringBloc _bloc = ScoringBloc();

class ScoringScreen extends StatefulWidget {
  @override
  _ScoringScreenState createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  List<String> players = ['Player 1', 'Player 2'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QueenDomino Counter'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              print('button');
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
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ScoringBloc, ScoringDetails>(
            bloc: _bloc,
            builder: (context, data) {
              ScoringDetails details = data;
              return ListView(
                children: <Widget>[
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                                  Container(),
                                ] +
                                [
                                  for (String player in players)
                                    Center(child: Text(player))
                                ],
                          ),
                        ] +
                        [
                          for (String category in kCategories)
                            scoreRow(title: category, details: details)
                        ] +
                        [
                          TableRow(
                            children: [
                              Text('Total'),
                              Center(
                                child: Text('${details.total(0)}'),
                              ),
                              Center(
                                child: Text('${details.total(1)}'),
                              ),
                            ],
                          ),
                        ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

TableRow scoreRow({
  String title,
  ScoringDetails details,
}) {
  return TableRow(
    children: <Widget>[
      Text(title),
      ScoringUnit(
        onChange: (newVal) {
          _bloc.add(ScoringEvent(
            type: title,
            base: int.parse(newVal),
            playerId: 0,
          ));
        },
      ),
      ScoringUnit(
        onChange: (newVal) {
          _bloc.add(
            ScoringEvent(
              type: title,
              base: int.parse(newVal),
              playerId: 1,
            ),
          );
        },
      ),
    ],
  );
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
    _controller.addListener(() {
      {
        if (_controller.text != '') {
          widget.onChange(_controller.text);
        }
      }
    });
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
    );
  }
}
