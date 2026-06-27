import 'package:book_lab/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<BookProvider>(context, listen: false).getAllBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
