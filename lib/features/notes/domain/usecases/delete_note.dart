import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/notes_repository.dart';

class DeleteNote {
  final NotesRepository repository;

  DeleteNote(this.repository);

   Future<Either<Failure, Unit>> call(int noteid) async {
    return await repository.deleteNoteById(noteid);
  }
}
