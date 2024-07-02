/*
import 'package:dartz/dartz.dart';
import 'package:example_clean_arch/core/choosedatasource/choose_data_sources.dart';
import 'package:example_clean_arch/core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../data_sources/data_sharedprefrence_source .dart';
import '../data_sources/data_sqflite_source.dart';
import '../model/note_model.dart';


class NotesRepositoryImpl implements NotesRepository {
  
  final SqfliteDataSource sqfliteDataSource;
  final SharedprefrenceDataSource sharedprefrenceDataSource ;
  final ChooseDataSqflite chooseDataSqflite ;

  NotesRepositoryImpl({ required this.chooseDataSqflite, required this.sqfliteDataSource,
   required this.sharedprefrenceDataSource});

  @override
  Future<Either<Failure,List<Note>>> getNotes() async{
    if(await chooseDataSqflite.isDatasourced){
      try{
       final dataOfSqflite = await sqfliteDataSource.getNotesSqflite();
        return Right(dataOfSqflite);
      }on EmptyCacheException{
         return Left(EmptyCacheFailure());
      }
    }else{
      try { 
        final dataOfSharedprefrence = await sharedprefrenceDataSource.getNotesSharedprefrences();
        return Right(dataOfSharedprefrence);
      }on EmptyCacheException{
         return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    
    final NoteModel noteModel = NoteModel(id:note.id, title: note.title, content: note.content);
    if(await chooseDataSqflite.isDatasourced){
      final addNoteSqflite = await sqfliteDataSource.addNotesSqflite(noteModel);
      return Right(addNoteSqflite);
    }else{
       final addNoteShared = await sharedprefrenceDataSource.addNotesSharedPrefrence(noteModel);
      return Right(addNoteShared);
  }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note)async {
     final NoteModel noteModel = NoteModel(id:note.id, title: note.title, content: note.content);
    if(await chooseDataSqflite.isDatasourced){
      final updateNoteSqflite = await sqfliteDataSource.updateNotesSqflite(noteModel);
      return Right(updateNoteSqflite);
    }else{
       final updateNoteShared = await sharedprefrenceDataSource.updateNotesSharedPrefrence(noteModel);
      return Right(updateNoteShared);
  }
  }

  @override
  Future<Either<Failure, Unit>> deleteNoteById(int id) async{
    if(await chooseDataSqflite.isDatasourced){
      final deleteOfSqflite = await sqfliteDataSource.deleteNotesSqflite(id);
      return Right(deleteOfSqflite);
    }else{
      final deleteOfSharedPrefrence = await sharedprefrenceDataSource.deleteNotesSharedPrefrence(id);
      return Right(deleteOfSharedPrefrence);
    }
  }


}
*/




import 'package:dartz/dartz.dart';
import 'package:example_clean_arch/core/choosedatasource/choose_data_sources.dart';
import 'package:example_clean_arch/core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../data_sources/data_sharedprefrence_source .dart';
import '../data_sources/data_sqflite.dart';
import '../model/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  
  final SqfliteData sqfliteData;
  final SharedprefrenceDataSource sharedprefrenceDataSource;
  final ChooseDataSqflite chooseDataSqflite;

  NotesRepositoryImpl({
    required this.chooseDataSqflite,
    required this.sqfliteData,
    required this.sharedprefrenceDataSource,
  });

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    return await _chooseDataSource<List<Note>>(
      sqfliteOperation: () => sqfliteData.getNotesSqflite(),
      sharedPreferenceOperation: () => sharedprefrenceDataSource.getNotesSharedprefrences(),
      failure: EmptyCacheFailure(),
    );
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    final NoteModel noteModel = NoteModel(id: note.id, title: note.title, content: note.content);
    return await _chooseDataSource<Unit>(
      sqfliteOperation: () => sqfliteData.addNotesSqflite(noteModel),
      sharedPreferenceOperation: () => sharedprefrenceDataSource.addNotesSharedPrefrence(noteModel),
      failure: DatabaseFailure(), 
    );
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    final NoteModel noteModel = NoteModel(id: note.id, title: note.title, content: note.content);
    return await _chooseDataSource<Unit>(
      sqfliteOperation: () => sqfliteData.updateNotesSqflite(noteModel),
      sharedPreferenceOperation: () => sharedprefrenceDataSource.updateNotesSharedPrefrence(noteModel),
      failure: DatabaseFailure(), 
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteNoteById(int id) async {
    return await _chooseDataSource<Unit>(
      sqfliteOperation: () => sqfliteData.deleteNotesSqflite(id),
      sharedPreferenceOperation: () => sharedprefrenceDataSource.deleteNotesSharedPrefrence(id),
      failure: DatabaseFailure(), 
    );
  }





  Future<Either<Failure, T>> _chooseDataSource<T>({
    required Future<T> Function() sqfliteOperation,
    required Future<T> Function() sharedPreferenceOperation,
    required Failure failure,
  }) async {
    if (await chooseDataSqflite.isDatasourced) {
      try {
        final result = await sqfliteOperation();
        return Right(result);
      } catch (e) {
        return Left(failure);
      }
    } else {
      try {
        final result = await sharedPreferenceOperation();
        return Right(result);
      } catch (e) {
        return Left(failure);
      }
    }
  }




}




 