import 'package:book_lab/const/theme/app_theme.dart';
import 'package:book_lab/data/library_db_services.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:book_lab/provider/book_provider.dart';
import 'package:book_lab/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LibraryDbServices.createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthorProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BookLab',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        home: Home(),
      ),
    );
  }
}
