import 'dart:typed_data';

import 'package:book_lab/data/library_db_services.dart';
import 'package:flutter/foundation.dart';

class AuthorProvider extends ChangeNotifier {
  final LibraryDbServices _dbServices = LibraryDbServices();

  Future<int> saveAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) {
    return _dbServices.insertAuthor(
      name: name,
      description: description,
      photo: photo,
    );
  }
}
