import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_ai/Screens/OptionScreen.dart';
import '../popup_dialouge.dart';

class TicTacToe extends StatefulWidget {
  static const String id = 'Game_page';
  static String selectedPlayer;
  static int spotsCount = 0;

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  void initState() {
    if (TicTacToe.selectedPlayer == 'X') {
      bestTurn();
      TicTacToe.spotsCount++;
    }
    super.initState();
  }

  var ai = 'X';
  var human = 'O';
  static String activePlayer = TicTacToe.selectedPlayer;
  //height of array
  int height = 3;
  int i, j;

  List board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
              color: Colors.blueAccent, fontSize: 30, fontFamily: 'Dosis'),
        ),
      ),
      backgroundColor: Colors.blue[100],
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          oneTwoDimensionIndex(index);
          return GestureDetector(
            onTap: () {
              oneTwoDimensionIndex(index);
              _tapped(i, j);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.blue[100]),
                  left: BorderSide(width: 1.0, color: Colors.blue[100]),
                  right: BorderSide(width: 1.0, color: Colors.blue[100]),
                  bottom: BorderSide(width: 1.0, color: Colors.blue[100]),
                ),
              ),
              child: Center(
                child: Text(
                  board[i][j],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void oneTwoDimensionIndex(int index) {
    j = index ~/ height;
    i = index % height;
  }

  void _tapped(int i, int j) {
    setState(() {
      if (activePlayer == human) {
        if (board[i][j] == '') {
          board[i][j] = human;
          TicTacToe.spotsCount++;
          activePlayer = ai;

          if (TicTacToe.spotsCount != 9) {
            bestTurn();
            TicTacToe.spotsCount++;
          }
        }
      }
    });

    if (_checkWinner() == 'tie' || TicTacToe.spotsCount == 9) {
      AlertBox.alertPopUp(context,
          alertTitle: 'Tie', alertText: "It's a tie", function: _clearBoard);
    } else if (_checkWinner() == 'X') {
      AlertBox.alertPopUp(context,
          alertTitle: 'X Won', alertText: "You Loose", function: _clearBoard);
    } else if (_checkWinner() == 'O') {
      AlertBox.alertPopUp(context,
          alertTitle: 'O Won', alertText: "You won", function: _clearBoard);
    }
  }

  void bestTurn() {
    int bestScore = -999;
    int iBestIndex;
    int jBestIndex;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          board[i][j] = ai;
          int score = minimax(board, 0, false);
          board[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            iBestIndex = i;
            jBestIndex = j;
          }
        }
      }
    }
    board[iBestIndex][jBestIndex] = ai;
    activePlayer = human;
  }

  var scores = {
    'X': 100,
    'O': -100,
    'tie': 0,
  };

  int minimax(List board, int depth, bool isMaximizing) {
    var result = _checkWinner();
    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      int bestScore = -999;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == '') {
            board[i][j] = ai;
            int score = minimax(board, depth + 1, false);
            bestScore = max(score, bestScore);
            board[i][j] = '';
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 999;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == '') {
            board[i][j] = human;
            int score = minimax(board, depth + 1, true);
            board[i][j] = '';
            bestScore = min(score, bestScore);
          }
        }
      }
      return bestScore;
    }
  }

  bool equals3(a, b, c) {
    return a == b && b == c && a != '';
  }

  String _checkWinner() {
    String winnerFlag;
    // horizontal
    for (int i = 0; i < 3; i++) {
      if (equals3(board[i][0], board[i][1], board[i][2])) {
        winnerFlag = board[i][0];
      }
    }

    //vertical
    for (int i = 0; i < 3; i++) {
      if (equals3(board[0][i], board[1][i], board[2][i])) {
        winnerFlag = board[0][i];
      }
    }

    // Diagonal
    if (equals3(board[0][0], board[1][1], board[2][2])) {
      winnerFlag = board[0][0];
    }
    if (equals3(board[2][0], board[1][1], board[0][2])) {
      winnerFlag = board[2][0];
    }

    int openSpots = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          openSpots++;
        }
      }
    }

    if (winnerFlag == null && openSpots == 0) {
      return 'tie';
    } else {
      return winnerFlag;
    }
  }

  void _clearBoard() {
    TicTacToe.spotsCount = 0;
    Navigator.popUntil(context, ModalRoute.withName(OptionScreen.id));
  }

  // ignore: must_call_super
  void dispose() {
    _clearBoard();
  }
}
