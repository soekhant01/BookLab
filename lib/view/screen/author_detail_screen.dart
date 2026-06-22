import 'dart:typed_data';

import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/data/author_model.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDetailScreen extends StatefulWidget {
  const AuthorDetailScreen({super.key, required this.authorData});

  final AuthorModel authorData;

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<AuthorProvider>(
        context,
        listen: false,
      ).getFavorite(widget.authorData.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppThemeTokens themeTokens = Theme.of(context).extension<AppThemeTokens>()!;
    AuthorModel authorData = widget.authorData;
    Uint8List? photo = authorData.photo;
    String name = authorData.name;
    String description = authorData.description;

    return Scaffold(
      body: Stack(
        // clipBehavior can appear something is overflow
        clipBehavior: Clip.none,

        children: [
          photo != null
              ? Image.memory(
                  photo,
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
              child: Consumer<AuthorProvider>(
                builder: (BuildContext context, provider, Widget? child) {
                  bool isFav = provider.isFav == 1;
                  return IconButton(
                    onPressed: () {
                      provider.updateFavorite(
                        widget.authorData.id,
                        isFav ? 0 : 1,
                      );
                    },
                    icon: isFav
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                  );
                },
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
                      name,
                      style: TextStyle(
                        fontSize: 32,
                        color: themeTokens.onBackground,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
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
