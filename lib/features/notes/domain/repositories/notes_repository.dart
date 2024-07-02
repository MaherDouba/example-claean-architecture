import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import 'package:dartz/dartz.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Unit>> addNote(Note note);
  Future<Either<Failure, Unit>> updateNote(Note note);
  Future<Either<Failure, Unit>> deleteNoteById(int id);
}
