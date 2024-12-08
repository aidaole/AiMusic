import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../common/log_util.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'bloc/play_list_bloc.dart';
import 'bloc/play_list_event.dart';
import 'bloc/play_list_state.dart';
import 'models/high_qulity_tags.dart';

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
          const SizedBox(
            height: 20,
          ),
          _buildSearchBar(context),
          // 可滚动的内容部分
          Expanded(
            child: NestedScrollView(
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
                        _buildLiveMusicList(context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ];
              },
              body: _buildHightQulityTabsBloc(context),
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
                return const Center(child: CircularProgressIndicator());
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

  Padding _buildRecommendPlayList(
      RequestPlayListRecommendSuccess state, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SizedBox(
        height: 180,
        width: 130,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: state.playList.recommend?[index].picUrl ?? "",
                height: 180,
                width: 130,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[800],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
    );
  }

  _buildLiveMusicList(BuildContext context) {
    const borderColor = Color(0xFFE80063);
    const double totalHeight = 80 + 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "正在直播 >",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: totalHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: "https://picsum.photos/180/180",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[800],
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
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
                          "直播中",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildHightQulityTabsBloc(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      buildWhen: (previous, current) =>
          current is RequestHighQualityTagsLoading ||
          current is RequestHighQualityTagsError ||
          current is RequestHighQualityTagsSuccess,
      builder: (context, state) {
        LogUtil.i(state, tag: _tag);
        if (state is RequestHighQualityTagsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RequestHighQualityTagsError) {
          return Center(child: Text(state.error));
        }
        if (state is RequestHighQualityTagsSuccess) {
          return _buildHighQulityTabs(context, state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildHighQulityTabs(
      BuildContext context, RequestHighQualityTagsSuccess state) {
    LogUtil.i("${state.tags.tags?.length}", tag: _tag);
    return DefaultTabController(
      length: state.tags.tags?.length ?? 0,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context);
        final pageController = PageController();

        if (!tabController.hasListeners) {
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              pageController.animateToPage(
                tabController.index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          });
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final firstTag = state.tags.tags?.first;
          if (firstTag != null) {
            context
                .read<PlayListBloc>()
                .add(RequestHighQualityPlayListEvent(cat: firstTag.name ?? ""));
          }
        });

        return Column(
          children: [
            TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                final currentTag = state.tags.tags?[index];
                if (currentTag != null) {
                  context.read<PlayListBloc>().add(
                      RequestHighQualityPlayListEvent(
                          cat: currentTag.name ?? ""));
                }
              },
              tabs:
                  state.tags.tags?.map((tag) => Tab(text: tag.name)).toList() ??
                      [],
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: state.tags.tags?.length ?? 0,
                onPageChanged: (index) {
                  tabController.animateTo(index);
                  final currentTag = state.tags.tags?[index];
                  if (currentTag != null) {
                    context.read<PlayListBloc>().add(
                        RequestHighQualityPlayListEvent(
                            cat: currentTag.name ?? ""));
                  }
                },
                itemBuilder: (context, index) {
                  final tag = state.tags.tags?[index];
                  if (tag == null) return const SizedBox();
                  return _buildHighQulityTabList(context, tag);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHighQulityTabList(BuildContext context, Tag tag) {
    return BlocBuilder<PlayListBloc, PlayListState>(
        buildWhen: (previous, current) =>
            (current is RequestHighQualityPlayListSuccess &&
                current.cat == tag.name) ||
            (current is RequestHighQualityPlayListLoading &&
                current.cat == tag.name) ||
            (current is RequestHighQualityPlayListError &&
                current.cat == tag.name),
        builder: (context, state) {
          LogUtil.i("${tag.name} state: $state", tag: _tag);
          if (state is RequestHighQualityPlayListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RequestHighQualityPlayListError) {
            return Center(child: Text(state.error));
          }
          if (state is RequestHighQualityPlayListSuccess) {
            LogUtil.i("${tag.name} state: ${state.playList.playlists?.length}",
                tag: _tag);
            return GridView.builder(
              itemCount: state.playList.playlists?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${state.playList.playlists?[index].coverImgUrl}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[800],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${state.playList.playlists?[index].name}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
