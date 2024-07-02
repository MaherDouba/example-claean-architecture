import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({required int id, required String title, required bool isDone})
      : super(id: id, title: title, isDone: isDone);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isDone: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_done': isDone,
    };
  }
}
