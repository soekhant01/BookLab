import 'dart:typed_data';

import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/data/model/book_model.dart';
import 'package:book_lab/provider/book_provider.dart';
import 'package:book_lab/view/screen/book_detail_screen.dart';
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
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    return ColoredBox(
      color: appThemeTokens.surface,
      child: Consumer<BookProvider>(
        builder: (_, provider, _) {
          List<BookModel> books = provider.books;
          return books.isEmpty
              ? Center(
                  child: Text(
                    "Empty Books",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    BookModel book = books[index];
                    Uint8List? cover = book.cover;
                    String? title = book.title;
                    String? name = book.name;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return BookDetailScreen(bookData: book);
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(
                          bottom: 16,
                          left: 16,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: appThemeTokens.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            if (cover != null)
                              Container(
                                width: 80,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: MemoryImage(cover),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            SizedBox(width: 8),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    "$title",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: appThemeTokens.onBackground,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    " Author: $name",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: appThemeTokens.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),

                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
