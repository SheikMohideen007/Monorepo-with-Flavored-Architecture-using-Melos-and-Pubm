import 'package:core/screens/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:notes_pro/screens/add_screen.dart';

class NotesProScreen extends StatefulWidget {
  const NotesProScreen({super.key});

  @override
  NotesProScreenState createState() => NotesProScreenState();
}

class NotesProScreenState extends State<NotesProScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      notes = AppSharedPrefs.getNotes();
    });
  }

  Future<void> _deleteNote(int index) async {
    await AppSharedPrefs.deleteNote(index);
    setState(() => notes.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Premium Notes')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, i) {
          final item = notes[i];
          final text = item['text'] as String? ?? '';
          final imagePath = item['imagePath'] as String?;
          return Dismissible(
            key: Key('$text-$i'),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => _deleteNote(i),
            child: ListTile(
              title: Text(text),
              leading: imagePath != null
                  ? Image.file(
                      File(imagePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : null,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(i),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddScreen(
              isPremium: true,
              type: 'Notes',
              onSave: (text, imagePath) async {
                if (imagePath == null) return;
                await AppSharedPrefs.addNote(text, imagePath);
                _loadNotes();
              },
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
