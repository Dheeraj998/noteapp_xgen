import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(NotesModel note) async {
    await _firestore.collection('notes').doc(note.id).set(note.toMap());
  }

  Stream<List<NotesModel>> getNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotesModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
