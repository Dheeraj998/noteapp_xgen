import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/custom_log.dart';
import 'package:notes_app_xgen/features/notes/data/note_repository.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';

class NotesProvider with ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NotesModel> notes = [];

  bool fetchNotesLoader = false;
  void fetchNotes(String userId) {
    fetchNotesLoader = true;
    notifyListeners();
    _notesRepository.getNotes(userId).listen((notesList) {
      customLog("----->>> $notesList");
      notes = notesList;
      fetchNotesLoader = false;
      notifyListeners();
    });
  }

  // Get Current User ID
  String getCurrentUserId() {
    return _auth.currentUser?.uid ?? '';
  }

  bool addNoteLoader = false;
  Future<bool> addNote(NotesModel note) async {
    addNoteLoader = true;
    notifyListeners();
    bool isSuccess = await _notesRepository.addNote(note);
    addNoteLoader = false;

    notifyListeners();
    return isSuccess;
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRepository.deleteNote(noteId);
    notifyListeners();
  }
}
