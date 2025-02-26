import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../common/log_util.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'views/high_quility_tabs_view.dart';
import 'views/recommend_playlist_view.dart';
import 'views/top_artiest_list_view.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static const String _tag = "ExplorePage";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        LogUtil.i("ExplorePage initState called", tag: _tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Scaffold _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Column(
        children: [
          const StatusBarPlaceHolder(),
          Expanded(
            child: _buidMainContent(context),
          ),
          SizedBox(
            height: defaultBottomNavigationBarHeight,
          )
        ],
      ),
    );
  }

  _buidMainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildSearchBar(context),
          // 可滚动的内容部分
          Expanded(
            child: NestedScrollView(
              // 使用默认的physics
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        RecommendPlaylistView(),
                        SizedBox(height: 20),
                        TopArtiestListView(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ];
              },
              body: const HighQulityTabsView(),
            ),
          ),
        ],
      ),
    );
  }

  _buildSearchBar(BuildContext context) {
    const double iconSize = 25.0;
    const int textAlpha = 80;
    return SizedBox(
      height: defaultActionBarHeight.toDouble(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(20),
          ),
          height: defaultActionBarHeight.toDouble(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: iconSize,
                color: Colors.white.withAlpha(textAlpha),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "搜索歌手, 歌曲, 专辑",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white.withAlpha(textAlpha)),
                ),
              ),
              Icon(
                Icons.camera_alt,
                size: iconSize,
                color: Colors.white.withAlpha(textAlpha),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
