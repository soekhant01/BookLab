import 'package:book_lab/view/widgets/bottom_nav.dart';
import 'package:book_lab/view/widgets/floating_action_btn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNav(),
      floatingActionButton: FloatingActionBtn(),
    );
  }
}
