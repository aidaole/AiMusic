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
      body: SafeArea(
        child: Column(
          children: [
            // 自定义 ActionBar，使用主题色
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              color: themeColor, // 设置背景色
              child: Row(
                children: [
                  Text(
                    "HomePage",
                    style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      color: Colors.white, // 文字改为白色
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: themeColor, // 设置底部导航栏背景色
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: themeColor, // 设置背景色
            elevation: 0,
            selectedItemColor: Colors.white, // 选中项为白色
            unselectedItemColor: Colors.white70, // 未选中项为半透明白色
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
