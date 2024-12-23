import 'package:ai_music/common/widgets/common_circle_loading.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/app_routes.dart';
import '../../routes/route_helper.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import '../../widgets/radius_container.dart';
import 'bloc/account_bloc.dart';
import 'bloc/account_event.dart';
import 'bloc/account_state.dart';
import 'models/account_model.dart';

class AccountInfoPage extends StatefulWidget {
  final AccountModel account;

  const AccountInfoPage({super.key, required this.account});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<AccountBloc>()
          .add(GetAccountPlaylistsEvent(uid: widget.account.userId));
      context
          .read<AccountBloc>()
          .add(GetAccountHistoryPlayListEvent(uid: widget.account.userId));
    });
  }

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
              Tab(text: "历史"),
            ],
          ),
          // Tab页面内容区域
          Expanded(
            child: TabBarView(
              children: [
                // 歌单页面
                BlocBuilder<AccountBloc, AccountState>(
                  buildWhen: (previous, current) {
                    return current is GetAccountPlaylistsSuccess ||
                        current is GetAccountPlaylistsLoading;
                  },
                  builder: (context, state) {
                    if (state is GetAccountPlaylistsSuccess) {
                      return ListView.builder(
                        itemCount: state.playlists.playlist?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _buildAccountPlaylistItem(
                              state, index, context);
                        },
                      );
                    }
                    return const Center(child: CommonCircleLoading());
                  },
                ),
                // 历史
                BlocBuilder<AccountBloc, AccountState>(
                  buildWhen: (previous, current) {
                    return current is GetAccountHistoryPlayListSuccess ||
                        current is GetAccountHistoryPlayListLoading;
                  },
                  builder: (context, state) {
                    if (state is GetAccountHistoryPlayListSuccess) {
                      return ListView.builder(
                        itemCount: state.historyPlayList.weekData?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildHistoryListItem(state, index, context);
                        },
                      );
                    }
                    return const Center(child: CommonCircleLoading());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildFansInfoWidget(BuildContext context, AccountModel account) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${account.follows} 关注",
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: 15,
        ),
        Text("${account.fans} 粉丝",
            style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }

  _buildActionBar(BuildContext context) {
    double iconSize = 25.0;
    return SizedBox(
      height: defaultActionBarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButtonWithBg(
            text: "有新消息",
            iconSize: iconSize,
            icon: Icons.notifications,
            onPressed: () {
              RouteHelper.push(context, AppRoutes.appSettings);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButtonWithBg(
            iconSize: iconSize,
            icon: Icons.shopping_bag,
            onPressed: () {
              RouteHelper.push(context, AppRoutes.appSettings);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButtonWithBg(
            iconSize: iconSize,
            icon: Icons.settings,
            onPressed: () {
              RouteHelper.push(context, AppRoutes.appSettings);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  _buildMusicWall() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(20),
        image: widget.account.backgroundUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(widget.account.avatarUrl),
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
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              color: Colors.transparent,
            ),
          ),
        ];
      },
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Expanded(
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                decoration: const BoxDecoration(
                    color: defaultBgColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      widget.account.nickname,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      widget.account.signature,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    _buildFansInfoWidget(context, widget.account),
                    const SizedBox(height: 20),
                    Expanded(child: _buildSongsListWidget()),
                  ],
                ),
              ),
              Positioned(
                top: -50,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Column(
                  children: [
                    SizedBox(
                        child: widget.account.avatarUrl.isNotEmpty
                            ? SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(widget.account.avatarUrl),
                                ),
                              )
                            : const Icon(
                                Icons.account_circle_rounded,
                                size: 100,
                              )),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Padding _buildAccountPlaylistItem(
      GetAccountPlaylistsSuccess state, int index, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            RadiusContainer(
              height: 80,
              width: 80,
              radius: 8,
              child: Image.network(
                state.playlists.playlist?[index].coverImgUrl ?? "",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.playlists.playlist?[index].name ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "共 ${state.playlists.playlist?[index].trackCount} 首",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ],
        ));
  }

  _buildHistoryListItem(
      GetAccountHistoryPlayListSuccess state, int index, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            RadiusContainer(
              height: 80,
              width: 80,
              radius: 8,
              child: Image.network(
                state.historyPlayList.weekData?[index].song?.al?.picUrl ?? "",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.historyPlayList.weekData?[index].song?.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.historyPlayList.weekData?[index].song?.al?.name ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class IconButtonWithBg extends StatelessWidget {
  const IconButtonWithBg({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
    this.text = "",
  });

  final IconData icon;
  final double iconSize;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(60),
        borderRadius: BorderRadius.circular(100),
      ),
      child: SizedBox(
        height: 41,
        child: Row(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: iconSize,
              ),
            ),
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(text),
              )
          ],
        ),
      ),
    );
  }
}
