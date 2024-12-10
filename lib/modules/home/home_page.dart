import 'package:ai_music/themes/theme_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/log_util.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../account/account_page.dart';
import '../explore/explore_page.dart';
import '../music/bloc/music_page_bloc.dart';
import '../music/music_page.dart';
import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _tag = "HomePage";

  final List<Widget> _pages = [
    const KeepAlivePage(child: ExplorePage()),
    const KeepAlivePage(child: MusicPage()),
    const KeepAlivePage(child: AccountPage()),
  ];

  int _preSelectedIndex = 0;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) => current is HomePageSwitchTabState,
      builder: (context, state) {
        logd("state: $state", tag: _tag);
        if (state is HomePageSwitchTabState) {
          _selectedIndex = state.index;
        }
        if (_preSelectedIndex == _selectedIndex && _selectedIndex == 1) {
          if (context.read<MusicPageBloc>().musicService.isPlaying) {
            context.read<MusicPageBloc>().musicService.pause();
          } else {
            context.read<MusicPageBloc>().musicService.play();
          }
        }
        Widget widget = Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomNavigationBar(_selectedIndex),
              ),
            ],
          ),
        );
        _preSelectedIndex = _selectedIndex;
        return widget;
      },
    );
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return CustomBottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        context.read<HomePageBloc>().add(HomeSwitchTabEvent(index));
      },
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      items: [
        const CustomBottomNavigationBarItem(
          icon: Icon(
            Icons.explore,
            size: 20,
          ),
          label: "发现",
        ),
        CustomBottomNavigationBarItem(
          icon: const Icon(
            Icons.music_note,
            size: 20,
          ),
          activeIcon: StreamBuilder(
            stream: context.read<MusicPageBloc>().musicService.playingStream,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              logd("snapshot.data: ${snapshot.data}", tag: _tag);
              bool isPlaying = snapshot.data ?? false;
              return Icon(
                isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: defaultBottomNavigationBarHeight - 16,
              );
            },
          ),
          label: selectedIndex == 1 ? null : "音乐",
        ),
        const CustomBottomNavigationBarItem(
          icon: Icon(Icons.person, size: 20),
          label: "我的",
        ),
      ],
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({
    super.key,
    required this.child,
  });

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
