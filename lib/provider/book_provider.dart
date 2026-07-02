import 'package:book_lab/data/book_db_services.dart';
import 'package:book_lab/data/model/book_model.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  final BookDbServices _bookDbServices = BookDbServices();
  List<BookModel> books = [];
  int isFav = 0;

  void getAllBooks() async {
    books = await _bookDbServices.getAllBooks();
    notifyListeners();
  }

  Future<int> saveBook({
    required String title,
    required String description,
    required int authorId,
    Uint8List? cover,
  }) async {
    final count = await _bookDbServices.insertAuthor(
      title: title,
      description: description,
      authorId: authorId,
      cover: cover,
    );
    getAllBooks();
    return count;
  }

  Future<int> getFavorite(int id) async {
    isFav = await _bookDbServices.getFavorite(id);
    notifyListeners();
    return isFav;
  }

  Future<int> updateFavorite(int id, int isFav) async {
    final result = await _bookDbServices.updateFavorite(id, isFav);
    getFavorite(id);
    return result;
  }

  Future<int> deleteBook(int id) async {
    int result = await _bookDbServices.deleteBook(id);
    getAllBooks();
    return result;
  }
}
