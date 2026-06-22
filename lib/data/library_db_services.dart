import 'dart:io';
import 'dart:typed_data';

import 'package:book_lab/data/author_model.dart';
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
    _createAuthorTable();
  }

  static Future<void> _createAuthorTable() async {
    return _database.execute(
      "create table if not exists $_authorTable (id integer primary key autoincrement, name text, description text, photo blob,fav integer);",
    );
  }

  Future<int> insertAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) {
    // using rawInsert(), to protect sql injection
    return _database.rawInsert(
      'insert into author (name,description,photo,fav) values (?,?,?,?)',
      [name, description, photo, null],
    );
  }

  Future<List<AuthorModel>> getAllAuthors() async {
    final listOfMap = await _database.rawQuery("select * from $_authorTable");
    return listOfMap.map((json) {
      return AuthorModel.fromJson(json);
    }).toList();
  }
}
