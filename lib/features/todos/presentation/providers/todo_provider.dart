import 'package:flutter/foundation.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';

class TodoProvider with ChangeNotifier {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoProvider({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  });

  bool loading = true;
  List<Todo> todos = [];

  void fetchTodos() async {
    loading = true;
    notifyListeners();
    final fetchedTodos = await getTodos();
    todos = fetchedTodos;
    loading = false;
    notifyListeners();
  }

  void addNewTodo(Todo todo) async {
     addTodo.call(todo);
    fetchTodos();
  }

  void updateExistingTodo(Todo todo) async {
     updateTodo.call(todo);
    fetchTodos();
  }

  void removeTodoById(int id) async {
     deleteTodo.call(id);
    fetchTodos();
  }
}
