import 'dart:io';

import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  final bool isPremium; // To show image picker
  final String type; // 'todo' or 'note'
  // Use image path in public API to avoid exposing XFile across package boundary
  final Function(String text, String? imagePath) onSave;

  const AddScreen({
    required this.isPremium,
    required this.type,
    required this.onSave,
  });

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add ${widget.type}')),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Text'),
          ),

          ElevatedButton(
            onPressed: () {
              widget.onSave(_textController.text, '_image?.path');
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
