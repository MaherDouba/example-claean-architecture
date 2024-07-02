import 'package:flutter/foundation.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/update_note.dart';

class NotesProvider with ChangeNotifier {
  final GetNotes getNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NotesProvider({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  });

  bool loading = true;
  List<Note> notes = [];

  void fetchNotes() async {
    loading = true;
    notifyListeners();
    final fetchedNotes = await getNotes(); //fix
    notes = fetchedNotes as List<Note>;
    loading = false;
    notifyListeners();
  }

  void addNewNote(Note note) async {
    addNote.call(note);
    fetchNotes();
  }

  void updateExistingNote(Note note) async {
     updateNote.call(note);
    fetchNotes();
  }

  void removeNoteById(int id) async {
     deleteNote.call(id);
    fetchNotes();
  }
}
