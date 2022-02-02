import 'package:flutter/material.dart';
import 'package:tictactoe_ai/Screens/OptionScreen.dart';

import 'Screens/TicTacToe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String id = 'Game_page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OptionScreen.id,
      routes: {
        OptionScreen.id: (context) => OptionScreen(),
        TicTacToe.id: (context) => TicTacToe(),
      },
    );
  }
}
