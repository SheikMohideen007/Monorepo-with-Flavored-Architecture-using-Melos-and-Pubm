import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static const String _keyTodos = 'todos';
  static const String _keyNotes = 'notes';

  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences (call this once, e.g., in main() before runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ========================
  // TODO OPERATIONS
  // ========================

  /// Get list of todos
  /// Each todo: base -> { "text": "Buy milk" }
  ///           premium -> { "text": "Buy milk", "imagePath": "/storage/.../image.jpg" }
  static List<Map<String, dynamic>> getTodos() {
    final String? todosJson = _prefs.getString(_keyTodos);
    if (todosJson == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(todosJson);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Save entire todos list
  static Future<bool> saveTodos(List<Map<String, dynamic>> todos) async {
    final String jsonString = jsonEncode(todos);
    return await _prefs.setString(_keyTodos, jsonString);
  }

  /// Add a new todo (used from AddScreen)
  static Future<bool> addTodo(String text, String? imagePath) async {
    final List<Map<String, dynamic>> todos = getTodos();

    final Map<String, dynamic> newTodo = {'text': text};
    if (imagePath != null && imagePath.isNotEmpty) {
      newTodo['imagePath'] = imagePath;
    }

    todos.add(newTodo);
    return await saveTodos(todos);
  }

  /// Delete a todo at index
  static Future<bool> deleteTodo(int index) async {
    final List<Map<String, dynamic>> todos = getTodos();
    if (index < 0 || index >= todos.length) return false;

    todos.removeAt(index);
    return await saveTodos(todos);
  }

  // ========================
  // NOTES OPERATIONS
  // ========================

  static List<Map<String, dynamic>> getNotes() {
    final String? notesJson = _prefs.getString(_keyNotes);
    if (notesJson == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(notesJson);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> saveNotes(List<Map<String, dynamic>> notes) async {
    final String jsonString = jsonEncode(notes);
    return await _prefs.setString(_keyNotes, jsonString);
  }

  static Future<bool> addNote(String text, String? imagePath) async {
    final List<Map<String, dynamic>> notes = getNotes();

    final Map<String, dynamic> newNote = {'text': text};
    if (imagePath != null && imagePath.isNotEmpty) {
      newNote['imagePath'] = imagePath;
    }

    notes.add(newNote);
    return await saveNotes(notes);
  }

  static Future<bool> deleteNote(int index) async {
    final List<Map<String, dynamic>> notes = getNotes();
    if (index < 0 || index >= notes.length) return false;

    notes.removeAt(index);
    return await saveNotes(notes);
  }

  // ========================
  // UTILS
  // ========================

  /// Clear all data (useful for testing or logout)
  static Future<void> clearAll() async {
    await _prefs.remove(_keyTodos);
    await _prefs.remove(_keyNotes);
  }
}
