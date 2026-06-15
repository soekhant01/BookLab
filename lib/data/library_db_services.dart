import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LibraryDbServices {
  static final _dbName = "library";
  static final _bookTable = "books";
  static final _authorTable = "author";

  static late Database _database;

  static Future<void> createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = "${documentDirectory.path}/$_dbName";
    _database = await openDatabase(dbPath, version: 1);
  }
}
