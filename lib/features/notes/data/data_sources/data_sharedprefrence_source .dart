import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/note_model.dart';

abstract class SharedprefrenceDataSource {

  Future<List<NoteModel>> getNotesSharedprefrences();
  Future<Unit> addNotesSharedPrefrence(NoteModel notemodel);
  Future<Unit> deleteNotesSharedPrefrence(int noteid);
  Future<Unit> updateNotesSharedPrefrence(NoteModel notemodel);
}


class SharedprefrenceDataSourceImpl implements SharedprefrenceDataSource {
  final SharedPreferences sharedPreferences ;

  SharedprefrenceDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<Unit> addNotesSharedPrefrence(NoteModel notemodel) async {
      List<NoteModel> notes = await getNotesSharedprefrences();
    int index = notes.indexWhere((n) => n.id == notemodel.id);
    if (index != -1) {
      notes[index] = notemodel;
      await saveNotes(notes);
    }
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteNotesSharedPrefrence(int noteid) async {
    List<NoteModel> notes = await getNotesSharedprefrences();
    notes.removeWhere((n) => n.id == noteid);
    await saveNotes(notes);
   return Future.value(unit);
  }

  @override
  Future<Unit> updateNotesSharedPrefrence(NoteModel notemodel) async {
     List<NoteModel> notes = await getNotesSharedprefrences();
    int index = notes.indexWhere((n) => n.id == notemodel.id);
    if (index != -1) {
      notes[index] = notemodel;
      await saveNotes(notes);
    }
    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getNotesSharedprefrences() async {
     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? dataString = sharedPrefs.getString('dataList');
    if (dataString != null) {
      List<dynamic> decodedList = json.decode(dataString);
      return decodedList.map((json) => NoteModel.fromJson(json)).toList();
    }
    return [];
  }
  

Future<void> saveNotes(List<NoteModel> notes) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String dataString = json.encode(notes.map((note) => note.toJson()).toList());
    await sharedPrefs.setString('dataList', dataString);
  }


}