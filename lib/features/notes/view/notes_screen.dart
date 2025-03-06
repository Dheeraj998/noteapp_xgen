import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/extension.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';
import 'package:notes_app_xgen/features/notes/provider/notes_provirer.dart';
import 'package:notes_app_xgen/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Consumer<NotesProvider>(builder: (context, note, _) {
        return ListView.builder(
          itemCount: note.notes.length,
          itemBuilder: (context, index) {
            NotesModel noteModel = note.notes[index];
            return NoteWidget(
              notesModel: noteModel,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Navigate to add note
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    this.notesModel,
  });
  final NotesModel? notesModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CommonText(text: notesModel?.title ?? ""),
      subtitle: CommonText(text: notesModel?.content ?? ""),
      onTap: () {}, // Navigate to note details
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => context.noteProvider.deleteNote(notesModel?.id ?? ""),
      ),
    );
  }
}
