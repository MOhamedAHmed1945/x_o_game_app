// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1_caluc/Screens/contact_list_screen.dart';

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, '');
  bool _isXTurn = true;
  String _winner = '';
  String _player1 = 'Player 1';
  String _player2 = 'Player 2';

  void _navName() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactListScreen()),
    );

    if (result != null && result is List<String>) {
      setState(() {
        _player1 = result[0];
        _player2 = result[1];
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isXTurn = true;
      _winner = '';
      _player1 = 'Player 1';
      _player2 = 'Player 2';
    });
  }

  void _makeMove(int index) {
    if (_board[index] != '' || _winner != '') return;
    setState(() {
      _board[index] = _isXTurn ? 'X' : 'O';
      _isXTurn = !_isXTurn;
      _winner = _checkWinner();
    });
  }

  String _checkWinner() {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], 
      [0, 3, 6], [1, 4, 7], [2, 5, 8], 
      [0, 4, 8], [2, 4, 6] 
    ];
    for (var line in lines) {
      if (_board[line[0]] != '' &&
          _board[line[0]] == _board[line[1]] &&
          _board[line[1]] == _board[line[2]]) {
        return _board[line[0]] == 'X' ? _player1 : _player2;
      }
    }
    return _board.contains('') ? '' : 'Draw';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_winner != '')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _winner == 'Draw' ? 'It\'s a Draw!' : 'Winner: $_winner',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _makeMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Player 1: $_player1',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Player 2: $_player2',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: _resetGame,
                    child: Text('Restart Game'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: _navName,
                    child: Text('Name Players'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
