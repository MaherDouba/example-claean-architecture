import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/notes/presentation/providers/notes_provider.dart';
import 'features/todos/presentation/providers/todo_provider.dart';
import 'features/notes/presentation/pages/home_page.dart';
import 'features/notes/presentation/pages/add_notes_page.dart';
import 'features/notes/presentation/pages/edit_notes_page.dart';

void main() {
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        title: 'Notes and Todos App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          '/addnotes': (context) => AddNotesPage(),
          '/editnotes': (context) => EditNotesPage(),
        },
      ),
    );
  }
}
