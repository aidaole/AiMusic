import 'package:flutter/material.dart';

import '../account/account_page.dart';
import '../explore/explore_page.dart';
import '../music/music_page.dart';

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
        body: Stack(
      children: [
        Expanded(child: _pages[_selectedIndex]),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomNavigationBar(),
        ),
      ],
    ));
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "音乐"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
