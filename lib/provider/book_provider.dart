import 'package:book_lab/data/book_db_services.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  final BookDbServices _bookDbServices = BookDbServices();

  void getAllBooks() async {
    final books = await _bookDbServices.getAllBooks();
  }
}
