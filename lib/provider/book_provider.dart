import 'package:book_lab/data/book_db_services.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  final BookDbServices _bookDbServices = BookDbServices();

  void getAllBooks() async {
    final books = await _bookDbServices.getAllBooks();
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
    return count;
  }
}
