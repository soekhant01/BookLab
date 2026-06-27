import 'dart:typed_data';

import 'package:book_lab/data/library_db_services.dart';

import 'author_model.dart';

class AuthorDbServices {
  static final _authorTable = "author";
  static final database = LibraryDbServices.database;

  static Future<void> createAuthorTable() async {
    return database.execute(
      "create table if not exists $_authorTable (id integer primary key autoincrement, name text, description text, photo blob,fav integer);",
    );
  }

  Future<int> insertAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) {
    // using rawInsert(), to protect sql injection
    return database.rawInsert(
      'insert into author (name,description,photo,fav) values (?,?,?,?)',
      [name, description, photo, null],
    );
  }

  Future<List<AuthorModel>> getAllAuthors() async {
    final listOfMap = await database.rawQuery("select * from $_authorTable");
    return listOfMap.map((json) {
      return AuthorModel.fromJson(json);
    }).toList();
  }

  Future<int> getFavorite(int id) async {
    final favMap = await database.rawQuery(
      "select fav from $_authorTable where id = $id",
    );
    if (favMap.isNotEmpty) {
      return (favMap.first["fav"] as int);
    }
    return 0;
  }

  Future<int> updateFavorite(int id, int isFav) async {
    return database.rawUpdate(
      "update $_authorTable set fav=$isFav where id=$id",
    );
  }

  Future<int> deleteAuthor(int id) {
    return database.rawDelete("delete from $_authorTable where id=$id");
  }

  Future<int> updateAuthor({
    required int id,
    required String name,
    required String description,
  }) {
    return database.update(
      _authorTable,
      {"name": name, "description": description},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
