// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameController1 = TextEditingController();
  final TextEditingController _nameController2 = TextEditingController();
  String _errorMessage = '';

  void _submitNames() {
    final player1 = _nameController1.text;
    final player2 = _nameController2.text;
    if (player1.isNotEmpty && player2.isNotEmpty) {
      Navigator.pop(context, [player1, player2]);
    } else {
      setState(() {
        _errorMessage = 'Both player names must be entered.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Player Names')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController1,
              decoration: InputDecoration(
                labelText: 'Player 1 Name',
                errorText: _nameController1.text.isEmpty && _errorMessage.isNotEmpty ? 'Player 1 name is required' : null,
              ),
            ),
            TextField(
              controller: _nameController2,
              decoration: InputDecoration(
                labelText: 'Player 2 Name',
                errorText: _nameController2.text.isEmpty && _errorMessage.isNotEmpty ? 'Player 2 name is required' : null,
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNames,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
