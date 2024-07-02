import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

 class InitialDatabase {
   static Database? _dataBase;

  Future<Database?> get dataBase async {
    if (_dataBase == null) {
      _dataBase = await _initializeDb();
    }
    return _dataBase;
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return mydb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        
      )
    ''');
  }

}