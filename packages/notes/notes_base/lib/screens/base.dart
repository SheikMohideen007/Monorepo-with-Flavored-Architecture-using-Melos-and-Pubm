import 'package:core/screens/add_screen.dart';
import 'package:core/screens/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:core/screens/add_screen.dart';
import 'package:core/screens/shared_prefs.dart';

class NotesBaseScreen extends StatefulWidget {
  @override
  _NotesBaseScreenState createState() => _NotesBaseScreenState();
}

class _NotesBaseScreenState extends State<NotesBaseScreen> {
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
      appBar: AppBar(title: Text('Base Notes')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, i) {
          final text = notes[i]['text'] as String? ?? '';
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
              isPremium: false,
              type: 'Notes',
              onSave: (text, imagePath) async {
                await AppSharedPrefs.addNote(text, null);
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
