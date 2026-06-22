import 'package:book_lab/data/author_model.dart';
import 'package:book_lab/data/library_db_services.dart';
import 'package:flutter/foundation.dart';

class AuthorProvider extends ChangeNotifier {
  final LibraryDbServices _dbServices = LibraryDbServices();
  int isFav = 0;
  List<AuthorModel> authors = [];

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

  Future<int> updateFavorite(int id, int isFav) async {
    final result = await _dbServices.updateFavorite(id, isFav);
    getFavorite(id);
    return result;
  }

  Future<int> getFavorite(int id) async {
    isFav = await _dbServices.getFavorite(id);
    notifyListeners();
    return isFav;
  }
}
