import 'dart:typed_data';

import 'package:book_lab/data/library_db_services.dart';
import 'package:book_lab/data/model/book_model.dart';

class BookDbServices {
  static final _bookTable = "books";
  static final _database = LibraryDbServices.database;

  static Future<void> createBookTable() async {
    await _database.execute('''
      create table if not exists $_bookTable (
id integer primary key autoincrement,
title text not null,
description text,
cover blob,
fav integer,
author_id integer not null,
foreign key(author_id) references author(id) on delete restrict
)
      ''');
  }

  Future<int> insertAuthor({
    required String title,
    required String description,
    Uint8List? cover,
    int? fav,
    required int authorId,
  }) {
    return _database.rawInsert(
      'insert into $_bookTable(title, description, cover,fav, author_id) values (?,?,?,?,?)',
      [title, description, cover, null, authorId],
    );
  }

  Future<List<BookModel>> getAllBooks() async {
    final listOfBooks = await _database.rawQuery(
      'select b.*, a.name From books b join author a on a.id=b.author_id',
    );
    return listOfBooks.map((json) {
      return BookModel.fromJson(json);
    }).toList();
  }

  Future<int> getFavorite(int id) async {
    final favMap = await _database.rawQuery(
      ""
      "select fav from books where id = $id",
    );
    if (favMap.isNotEmpty) {
      return (favMap.first["fav"] as int);
    }
    return 0;
  }

  Future<int> updateFavorite(int id, int isFav) async {
    return _database.rawUpdate(
      "update $_bookTable set fav=$isFav where id=$id",
    );
  }
}
