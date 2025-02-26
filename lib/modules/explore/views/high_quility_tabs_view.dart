import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/log_util.dart';
import '../../../common/widgets/common_circle_loading.dart';
import '../../../common/widgets/common_network_image.dart';
import '../../../routes/app_routes.dart';
import '../bloc/play_list_bloc.dart';
import '../bloc/play_list_event.dart';
import '../bloc/play_list_state.dart';
import '../models/high_qulity_tags.dart';

class HighQulityTabsView extends StatefulWidget {
  const HighQulityTabsView({super.key});

  @override
  State<HighQulityTabsView> createState() => _HighQulityTabsViewState();
}

class _HighQulityTabsViewState extends State<HighQulityTabsView> {
  final String _tag = "HighQulityTabsView";

  // 使用一个Set来记录已经触发加载更多的标签，避免重复加载
  bool _isLoadingMore = false;

  @override
  void dispose() {
    _isLoadingMore = false;
    super.dispose();
  }

  // 加载更多数据
  void _onLoadMore(String tagName) {
    // 如果该标签正在加载更多，则不重复触发
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    context
        .read<PlayListBloc>()
        .add(RequestHighQualityPlayListLoadMoreEvent(cat: tagName));
  }

  @override
  Widget build(BuildContext context) {
    return _buildHightQulityTabsBloc(context);
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
          return const Center(child: CommonCircleLoading());
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

        // ignore: invalid_use_of_protected_member
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
                  return _buildTabContent(context, tag);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabContent(BuildContext context, Tag tag) {
    final String tagName = tag.name ?? "";

    return BlocBuilder<PlayListBloc, PlayListState>(
      buildWhen: (previous, current) =>
          (current is RequestHighQualityPlayListSuccess &&
              current.cat == tagName) ||
          (current is RequestHighQualityPlayListLoading &&
              current.cat == tagName) ||
          (current is RequestHighQualityPlayListError &&
              current.cat == tagName) ||
          (current is RequestHighQualityPlayListLoadMoreSuccess &&
              current.cat == tagName),
      builder: (context, state) {
        logd("$tagName state: $state", tag: _tag);

        if (state is RequestHighQualityPlayListLoading) {
          return const Center(child: CommonCircleLoading());
        }

        if (state is RequestHighQualityPlayListError) {
          return Center(child: Text(state.error));
        }

        List playlists = [];
        bool isLoadingMore = false;

        if (state is RequestHighQualityPlayListSuccess) {
          playlists = state.playList.playlists ?? [];
        } else if (state is RequestHighQualityPlayListLoadMoreSuccess) {
          playlists = state.playList.playlists ?? [];
          isLoadingMore = state.isLoadingMore;
        }
        _isLoadingMore = isLoadingMore;

        return _buildPlayListView(tagName, playlists, isLoadingMore);
      },
    );
  }

  NotificationListener<ScrollNotification> _buildPlayListView(
      String tagName, List<dynamic> playlists, bool isLoadingMore) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // 当滚动到底部时加载更多
        if (notification is ScrollUpdateNotification) {
          if (notification.metrics.extentAfter < 200) {
            _onLoadMore(tagName);
          }
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              // 不使用ScrollController，而是使用NotificationListener
              // 这样可以保持嵌套滑动的正常工作
              itemCount: playlists.length + (isLoadingMore ? 1 : 0),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                // 显示加载更多的指示器
                if (index == playlists.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CommonCircleLoading(),
                    ),
                  );
                }

                final playlist = playlists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.playListDetail,
                      arguments: playlist.id,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: CommonNetworkImage(
                              imageUrl: '${playlist.coverImgUrl}',
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${playlist.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
