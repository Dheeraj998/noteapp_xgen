import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/app_colors.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';
import 'package:notes_app_xgen/features/notes/provider/notes_provider.dart';
import 'package:notes_app_xgen/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/custom_button.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: titleController,
                labelText: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter a title';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: contentController,
                labelText: 'Content',
                // maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Enter note content';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // noteProvider.isLoading
              //     ? const CircularProgressIndicator()
              //     : CustomButton(
              //         text: 'Save Note',
              //         onPressed: () async {
              //           if (_formKey.currentState!.validate()) {
              //             bool success = await noteProvider.addNote(
              //               title: titleController.text,
              //               content: contentController.text,
              //             );
              //             if (success) {
              //               Navigator.pop(context);
              //             } else {
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 const SnackBar(
              //                     content: Text('Failed to add note')),
              //               );
              //             }
              //           }
              //         },
              //       ),

              Consumer<NotesProvider>(builder: (context, note, _) {
                return CommonButton(
                    onLoading: note.addNoteLoader,
                    buttonHeight: 50,
                    buttonStyle: TextStyle(color: AppColors.white),
                    buttonWidth: double.maxFinite,
                    buttonColor: AppColors.secondary,
                    borderRadius: 5,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String noteId =
                            const Uuid().v4(); // Generate a unique ID
                        String userId =
                            note.getCurrentUserId(); // Get current user ID

                        NotesModel newNote = NotesModel(
                          id: noteId,
                          userId: userId,
                          title: titleController.text,
                          content: contentController.text,
                          timestamp: DateTime.now(),
                        );
                        FocusScope.of(context).unfocus();
                        bool? success = await note.addNote(newNote);
                        if (success == true) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Failed to add note')),
                          );
                        }
                      }
                    },
                    buttonText: "Add Note");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
