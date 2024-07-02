import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../data_sources/todo_data_source.dart';
import '../model/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl({required this.dataSource});

  @override
  List<Todo> getTodos() {
    return dataSource.fetchTodos().map((todo) => TodoModel.fromJson(todo)).toList();
  }

  @override
  void addTodo(Todo todo) {
    dataSource.addTodo(TodoModel(id: todo.id, title: todo.title, isDone: todo.isDone).toJson());
  }

  @override
  void updateTodo(Todo todo) {
    dataSource.updateTodo(TodoModel(id: todo.id, title: todo.title, isDone: todo.isDone).toJson());
  }

  @override
  void deleteTodoById(int id) {
    dataSource.deleteTodoById(id);
  }
}
