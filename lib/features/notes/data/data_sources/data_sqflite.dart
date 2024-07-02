import 'package:dartz/dartz.dart';
import 'package:example_clean_arch/features/notes/data/model/note_model.dart';

abstract class SqfliteData  {

  Future<List<NoteModel>> getNotesSqflite();
  Future<Unit> addNotesSqflite(NoteModel notemodel);
  Future<Unit> deleteNotesSqflite(int noteid);
  Future<Unit> updateNotesSqflite(NoteModel notemodel);
}

class SqfliteDataSourceImpl implements SqfliteData {
  
  @override
  Future<List<NoteModel>> getNotesSqflite() async {
     throw UnimplementedError();
  }
  
  @override
  Future<Unit> addNotesSqflite(NoteModel notemodel) {
    // TODO: implement AddNotesSharedprefrences
    throw UnimplementedError();
  }
  
  @override
  Future<Unit> deleteNotesSqflite(int noteid) {
    // TODO: implement DeleteNotesSharedprefrences
    throw UnimplementedError();
  }
  
  @override
  Future<Unit> updateNotesSqflite(NoteModel notemodel) {
    
    throw UnimplementedError();
  }
  
  
}