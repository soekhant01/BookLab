import 'package:book_lab/view/screen/author_page.dart';
import 'package:book_lab/view/screen/book_page.dart';
import 'package:book_lab/view/widgets/add_author_bottom_sheet.dart';
import 'package:book_lab/view/widgets/bottom_nav.dart';
import 'package:book_lab/view/widgets/floating_action_btn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        onSelected: (int index) {
          setState(() {
            _index = index;
          });
        },
      ),
      floatingActionButton: (_index == 0 || _index == 1)
          ? FloatingActionBtn(
              onPress: () {
                if (_index == 1) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return AddAuthorBottomSheet();
                    },
                  );
                }
              },
            )
          : null,
      body: switch (_index) {
        0 => BookPage(),
        1 => AuthorPage(),
        _ => SizedBox(),
      },
    );
  }
}
