import '../entities/todo.dart';

abstract class TodoRepository {
  List<Todo> getTodos();
  void addTodo(Todo todo);
  void updateTodo(Todo todo);
  void deleteTodoById(int id);
}
