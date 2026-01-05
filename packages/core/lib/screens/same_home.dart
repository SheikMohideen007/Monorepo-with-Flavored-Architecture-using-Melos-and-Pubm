import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common Home')),
      body: const Center(
        child: Text(
          'Common For Todos and Notes Apps',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
