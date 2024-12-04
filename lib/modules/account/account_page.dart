import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';
import "../../themes/theme_size.dart";
import '../login/phone_code_login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildMainContent(context)),
        SizedBox(
          height: defaultBottomNavigationBarHeight,
        )
      ],
    );
  }

  Stack _buildMainContent(BuildContext context) {
    return Stack(
      children: [
        // 底层音乐墙
        _buildMusicWall(),
        // 可滑动的内容区域
        _buildAccountInfoWidget(),
        // 顶部固定操作栏
        Column(
          children: [
            _buildStatusBar(context),
            _buildActionBar(context),
          ],
        ),
      ],
    );
  }

  DraggableScrollableSheet _buildAccountInfoWidget() {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        // 获取底部导航栏高度，如果没有设置可以使用默认值
        final bottomPadding = MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: defaultBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 50), // 为头像留出空间
                    Text(
                      "MGONE",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    _buildFansInfoWidget(context),
                    const SizedBox(height: 20),
                    // 使用 LayoutBuilder 来获取剩余可用空间
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // 计算列表区域的高度
                        // 总高度减去上方内容高度(约110)和底部导航栏高度
                        final availableHeight =
                            MediaQuery.of(context).size.height * 0.8 - 130 - bottomPadding;
                        return SizedBox(
                          height: availableHeight,
                          child: _buildSongsListWidget(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // 使用 Positioned 将头像放置在顶部并超出容器
            const Positioned(
              top: -50, // 负值使头像向上偏移
              left: 0,
              right: 0,
              child: Center(
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DefaultTabController _buildSongsListWidget() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          // Tab栏
          const TabBar(
            labelColor: Colors.white, // 选中的标签颜色
            unselectedLabelColor: Colors.grey, // 未选中的标签颜色
            indicatorColor: Colors.white, // 指示器颜色
            dividerColor: Colors.transparent, // 去掉分隔线
            tabs: [
              Tab(text: "歌单"),
              Tab(text: "下载"),
              Tab(text: "历史播放"),
              Tab(text: "视频"),
            ],
          ),
          // Tab页面内容区域
          Expanded(
            child: TabBarView(
              children: [
                // 歌单页面
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text(
                        "歌单 ${index + 1}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
                // 下载页面
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.download_done),
                      title: Text(
                        "已下载歌曲 ${index + 1}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
                // 历史播放页面
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(
                        "最近播放 ${index + 1}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
                // 视频页面
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.video_library),
                      title: Text(
                        "视频 ${index + 1}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildFansInfoWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("48 关注", style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: 15,
        ),
        Text("2 粉丝", style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: 15,
        ),
        Text("0 获得", style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }

  _buildActionBar(BuildContext context) {
    double iconSize = 30.0;
    double padding = 10.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            Icons.alarm,
            size: iconSize,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            Icons.shopping_bag,
            size: iconSize,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const PhoneCodeLoginPage()));
            },
            icon: Icon(
              Icons.settings,
              size: iconSize,
            ),
          ),
        )
      ],
    );
  }

  _buildStatusBar(BuildContext context) {
    return SizedBox(
      height: defaultStatusBarHeight.toDouble(),
    );
  }

  _buildMusicWall() {
    return Container(
      color: Colors.blue.withAlpha(20),
    );
  }
}
