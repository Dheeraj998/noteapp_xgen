import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_xgen/core/utils/app_colors.dart';
import 'package:notes_app_xgen/core/utils/app_routes.dart';
import 'package:notes_app_xgen/core/utils/extension.dart';
import 'package:notes_app_xgen/core/utils/theme_provider.dart';
import 'package:notes_app_xgen/features/notes/model/notes_model.dart';
import 'package:notes_app_xgen/features/notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.authProvider.user;
      if (user != null) {
        Provider.of<NotesProvider>(context, listen: false).fetchNotes(user.uid);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(themeProvider.isDarkMode
              ? Icons.wb_sunny
              : Icons.nightlight_round),
          onPressed: () => themeProvider.toggleTheme(),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Loggedout successfully')));
                context.authProvider.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (_) => false);
              }),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, note, _) {
          if (note.notes.isEmpty) {
            return Center(
              child: Text(
                "No notes available!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: note.notes.length,
            itemBuilder: (context, index) {
              NotesModel noteModel = note.notes[index];
              return NoteCard(
                  note: noteModel,
                  onDelete: () {
                    note.deleteNote(noteModel.id ?? "");
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deleted successfully')));
                  },
                  onTap: () {});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addNote);
        },
        backgroundColor: AppColors.background,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final NotesModel note;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Card(
      color: isDarkMode ? theme.cardColor : Colors.white,
      elevation: isDarkMode ? 2 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Note Title
              Text(
                note.title ?? "",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Note Content
              Text(
                note.content ?? "",
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),

              // Footer: Date & Delete Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Timestamp
                  Text(
                    DateFormat('MMM dd, yyyy • hh:mm a')
                        .format(note.timestamp!),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),

                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
