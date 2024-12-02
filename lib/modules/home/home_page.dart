import 'dart:io';

import 'package:flutter/material.dart';

import '../explore/explore_page.dart';
import '../music/music_page.dart';
import '../account/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const ExplorePage(),
    const MusicPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 56,
            child: Row(
              children: [
                Text(
                  "HomePage",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                )
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      )),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "发现"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "音乐"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
            ],
          ),
        ),
      ),
    );
  }
}
