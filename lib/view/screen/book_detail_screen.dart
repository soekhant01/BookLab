import 'dart:typed_data';

import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/data/model/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key, required this.bookData});

  final BookModel bookData;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    AppThemeTokens themeTokens = Theme.of(context).extension<AppThemeTokens>()!;
    BookModel bookData = widget.bookData;
    Uint8List? cover = bookData.cover;
    String? name = bookData.name;
    String? title = bookData.title;
    String? description = bookData.description;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          cover != null
              ? Image.memory(
                  cover,
                  height: 350,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Container(color: themeTokens.background, height: 350),

          Positioned(
            top: 50,
            left: 30,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeTokens.backBtnBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 30,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeTokens.backBtnBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              ),
            ),
          ),

          Positioned(
            bottom: -350,
            left: 50,
            right: 50,
            height: 400,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        fontSize: 32,
                        color: themeTokens.onBackground,
                      ),
                    ),
                    SizedBox(height: 8.0),

                    Text(
                      "Author: $name",
                      style: TextStyle(
                        fontSize: 24,
                        color: themeTokens.onBackground,
                      ),
                    ),
                    SizedBox(height: 8.0),

                    Text(
                      "$description",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeTokens.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
