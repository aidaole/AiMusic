import 'dart:io';

import 'package:ai_music/themes/theme_color.dart';
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

  // 定义统一的主题色
  static const Color themeColor = defaultBgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
              ),
              height: MediaQuery.of(context).padding.top + 56,
              color: themeColor.withOpacity(0.8),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "HomePage",
                      style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: themeColor,
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: themeColor,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
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
