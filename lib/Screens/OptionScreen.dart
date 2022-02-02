import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_ai/Screens/TicTacToe.dart';

class OptionScreen extends StatelessWidget {
  static const String id = 'Option_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyStatelessWidget(),
        ],
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 100.0,
            backgroundImage: AssetImage('assets/images/ticTacToe.png'),
          ),
          SizedBox(
            height: 70.0,
          ),
          Text(
            'The first turn will be of?',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                TicTacToe.selectedPlayer = 'O';
                Navigator.pushNamed(context, TicTacToe.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text('Human',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 30)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                TicTacToe.selectedPlayer = 'X';
                Navigator.pushNamed(context, TicTacToe.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text('AI Bot',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
