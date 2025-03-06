import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_xgen/core/utils/custom_log.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Add Note to Firestore**
  Future<bool> addNote(NotesModel note) async {
    try {
      await _firestore.collection('notes').doc(note.id).set(note.toMap());
      return true;
    } on FirebaseException catch (e) {
      customLog("Firebase Error: ${e.message}");
      return false;
    } catch (e) {
      customLog("Unexpected Error: $e");
      return false;
    }
  }

  /// **Get User-Specific Notes from Firestore**
  Stream<List<NotesModel>> getNotes(String userId) {
    try {
      return _firestore
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => NotesModel.fromMap(doc.data()))
              .toList());
    } on FirebaseException catch (e) {
      customLog("Firebase Error: ${e.message}");
      return const Stream.empty();
    } catch (e) {
      customLog("Unexpected Error: $e");
      return const Stream.empty();
    }
  }

  /// **Delete Note from Firestore**
  Future<bool> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
      return true;
    } on FirebaseException catch (e) {
      customLog("Firebase Error: ${e.message}");
      return false;
    } catch (e) {
      customLog("Unexpected Error: $e");
      return false;
    }
  }
}
