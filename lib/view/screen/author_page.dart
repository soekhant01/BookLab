import 'dart:typed_data';

import 'package:book_lab/provider/author_provider.dart';
import 'package:book_lab/view/screen/author_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/theme/app_theme_tokens.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // following will work after all widget ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<AuthorProvider>(context, listen: false).getAllAuthors();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    return ColoredBox(
      color: appThemeTokens.surface,
      child: Consumer<AuthorProvider>(
        builder: (_, provider, _) {
          List<Map<String, dynamic>> authors = provider.authors;
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (context, position) {
              Map<String, dynamic> author = authors[position];
              Uint8List? photo = author['photo'];
              String name = author['name'];
              String description = author['description'];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return AuthorDetailScreen(authorData: author);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: appThemeTokens.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      if (photo != null)
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          backgroundImage: MemoryImage(photo),
                        ),
                      SizedBox(width: 8),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 17,
                                color: appThemeTokens.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              description,
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
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
