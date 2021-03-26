import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/providers/mode_provider.dart';
import 'package:queendomino_counter/screens/scoringScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ModeProvider()),
        BlocProvider(
          create: (BuildContext context) => ScoringBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Queendomino Counter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ScoringScreen(),
      ),
    );
  }
}
