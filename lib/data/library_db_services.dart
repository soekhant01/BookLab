import 'dart:io';

import 'package:book_lab/data/author_db_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LibraryDbServices {
  static final _dbName = "library";

  static late Database _database;

  static Database get database => _database;

  static Future<void> createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = "${documentDirectory.path}/$_dbName";
    _database = await openDatabase(dbPath, version: 1);
    AuthorDbServices.createAuthorTable();
  }
}
