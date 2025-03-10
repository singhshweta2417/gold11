import 'dart:math';
import 'package:flutter/material.dart';



class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  TicTacToeScreenState createState() => TicTacToeScreenState();
}

class TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, '');
  bool _isPlayerTurn = true;
  String _winner = '';
  int _difficulty = 1; // Difficulty level (1 to 10)

  void _handleTap(int index) {
    if (_board[index] != '' || _winner != '') return;

    setState(() {
      _board[index] = 'X'; // Player move
      _isPlayerTurn = false;
    });

    _checkWinner();

    if (!_isPlayerTurn && _winner == '') {
      Future.delayed(const Duration(milliseconds: 500), _botMove);
    }
  }

  void _botMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (_board[i] == '') {
        emptyCells.add(i);
      }
    }

    if (_difficulty >= 7) {
      // Hard mode: Bot tries to win
      int winningMove = _findWinningMove('O');
      if (winningMove != -1) {
        _makeMove(winningMove, 'O');
        return;
      }
    }

    if (_difficulty >= 4) {
      // Medium mode: Bot blocks player's winning move
      int blockingMove = _findWinningMove('X');
      if (blockingMove != -1) {
        _makeMove(blockingMove, 'O');
        return;
      }
    }

    // Random move for Easy mode
    if (emptyCells.isNotEmpty) {
      Random random = Random();
      int randomIndex = emptyCells[random.nextInt(emptyCells.length)];
      _makeMove(randomIndex, 'O');
    }
  }

  void _makeMove(int index, String player) {
    setState(() {
      _board[index] = player;
      _isPlayerTurn = true;
    });

    _checkWinner();
  }

  int _findWinningMove(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      int countPlayer = 0;
      int emptyIndex = -1;

      for (int index in pattern) {
        if (_board[index] == player) {
          countPlayer++;
        } else if (_board[index] == '') {
          emptyIndex = index;
        }
      }

      if (countPlayer == 2 && emptyIndex != -1) {
        return emptyIndex;
      }
    }

    return -1;
  }

  void _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String a = _board[pattern[0]];
      String b = _board[pattern[1]];
      String c = _board[pattern[2]];
      if (a == b && b == c && a != '') {
        setState(() {
          _winner = a == 'X' ? 'Player' : 'Bot';
        });
        return;
      }
    }

    if (!_board.contains('') && _winner == '') {
      setState(() {
        _winner = 'Draw';
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isPlayerTurn = true;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(),
          if (_winner != '')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Winner: $_winner',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Difficulty:'),
              Slider(
                value: _difficulty.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: '$_difficulty',
                onChanged: (value) {
                  setState(() {
                    _difficulty = value.toInt();
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
