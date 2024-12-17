import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../routes/route_helper.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'models/account_model.dart';

class AccountInfoPage extends StatelessWidget {
  final AccountModel account;

  const AccountInfoPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildMainContent(context)),
        SizedBox(height: defaultBottomNavigationBarHeight)
      ],
    );
  }

  Stack _buildMainContent(BuildContext context) {
    return Stack(
      children: [
        // 底层音乐墙
        _buildMusicWall(),
        // 可滑动的内容区域
        _buildAccountInfo(context),
        // 顶部固定操作栏
        Column(
          children: [
            const StatusBarPlaceHolder(),
            _buildActionBar(context),
          ],
        ),
      ],
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
        Text("${account.follows} 关注", style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: 15,
        ),
        Text("${account.fans} 粉丝", style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: 15,
        ),
        Text("${account.gained} 获得", style: Theme.of(context).textTheme.titleSmall),
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
              RouteHelper.push(context, AppRoutes.appSettings);
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

  _buildMusicWall() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(20),
        image: account.backgroundUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(account.avatarUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  _buildAccountInfo(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxScrolled) {
        return [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
            collapsedHeight: 300,
            toolbarHeight: 300,
          ),
        ];
      },
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: defaultBgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                children: [
                  SizedBox(
                      width: 100.1,
                      height: 100.1,
                      child: Align(
                        alignment: const FractionalOffset(0.5, -500),
                        child: account.avatarUrl.isNotEmpty
                            ? SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(account.avatarUrl),
                                ),
                              )
                            : const Icon(
                                Icons.account_circle_rounded,
                                size: 100,
                              ),
                      )),
                  Text(
                    account.nickname,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    account.signature,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  _buildFansInfoWidget(context),
                  const SizedBox(height: 20),
                  Expanded(child: _buildSongsListWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
