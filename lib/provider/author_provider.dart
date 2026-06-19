import 'package:book_lab/data/library_db_services.dart';
import 'package:flutter/foundation.dart';

class AuthorProvider extends ChangeNotifier {
  final LibraryDbServices _dbServices = LibraryDbServices();
  List<Map<String, dynamic>> authors = [];

  void getAllAuthors() async {
    authors = await _dbServices.getAllAuthors();
    notifyListeners(); // to refresh ui after read data
  }

  Future<int> saveAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) async {
    final count = await _dbServices.insertAuthor(
      name: name,
      description: description,
      photo: photo,
    );
    getAllAuthors();
    return count;
  }
}
