import 'package:flutter/material.dart';
import 'package:notes_app_xgen/features/notes/data/note_repository.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';

class NotesProvider with ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepository();
  List<NotesModel> notes = [];

  void fetchNotes(String userId) {
    _notesRepository.getNotes(userId).listen((notesList) {
      notes = notesList;
      notifyListeners();
    });
  }

  Future<void> addNote(NotesModel note) async {
    await _notesRepository.addNote(note);
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRepository.deleteNote(noteId);
    notifyListeners();
  }
}
