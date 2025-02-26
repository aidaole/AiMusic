import 'package:ai_music/routes/route_helper.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/high_quility_tabs_view.dart';

import '../../common/log_util.dart';
import '../../common/widgets/common_circle_loading.dart';
import '../../common/widgets/common_network_image.dart';
import '../../routes/app_routes.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'bloc/play_list_bloc.dart';
import 'bloc/play_list_event.dart';
import 'bloc/play_list_state.dart';

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
        context.read<PlayListBloc>().add(RequestPlayListRecommendEvent());
        context.read<PlayListBloc>().add(RequestTopArtistsEvent());
        context.read<PlayListBloc>().add(RequestHighQualityTagsEvent());
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
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildRecommendPlayListBloc(context),
                        const SizedBox(height: 20),
                        _buildTopArtistListBloc(context),
                        const SizedBox(height: 20),
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

  _buildRecommendPlayListBloc(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "听腻了?试试别的",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: BlocBuilder<PlayListBloc, PlayListState>(
            buildWhen: (previous, current) =>
                current is RequestPlayListRecommendSuccess ||
                current is RequestPlayListRecommendLoading ||
                current is RequestPlayListRecommendError,
            builder: (context, state) {
              LogUtil.i(state, tag: _tag);
              if (state is RequestPlayListRecommendLoading) {
                return const Center(child: CommonCircleLoading());
              }
              if (state is RequestPlayListRecommendError) {
                return Center(child: Text(state.error));
              }
              if (state is RequestPlayListRecommendSuccess) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.playList.recommend?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildRecommendPlayList(state, index, context);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  _buildRecommendPlayList(
      RequestPlayListRecommendSuccess state, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.playListDetail,
            arguments: state.playList.recommend?[index].id);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: SizedBox(
          height: 180,
          width: 130,
          child: Stack(
            children: [
              SizedBox(
                height: 180,
                width: 130,
                child: CommonNetworkImage(
                  imageUrl: state.playList.recommend?[index].picUrl ?? "",
                  borderRadius: BorderRadius.circular(10),
                  width: 130,
                  height: 180,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    state.playList.recommend?[index].name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTopArtistListBloc(BuildContext context) {
    const borderColor = Color(0xFFE80063);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "推荐歌手",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<PlayListBloc, PlayListState>(
          buildWhen: (previous, current) =>
              current is RequestTopArtistsSuccess ||
              current is RequestTopArtistsLoading ||
              current is RequestTopArtistsError,
          builder: (context, state) {
            LogUtil.i(state, tag: _tag);
            if (state is RequestTopArtistsLoading) {
              return const Center(child: CommonCircleLoading());
            }
            if (state is RequestTopArtistsError) {
              return Center(child: Text(state.error));
            }
            if (state is RequestTopArtistsSuccess) {
              return _buildTopArtistList(state, borderColor);
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  SizedBox _buildTopArtistList(
      RequestTopArtistsSuccess state, Color borderColor) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              RouteHelper.push(context, AppRoutes.artiestDetail,
                  arguments: state.topArtists.artists?[index].id);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CommonNetworkImage(
                      imageUrl: "${state.topArtists.artists?[index].img1v1Url}",
                      width: 80,
                      height: 80,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${state.topArtists.artists?[index].name}",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
