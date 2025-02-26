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

class HighQulityTabsView extends StatelessWidget {
  static const String _tag = "HighQulityTabsView";
  const HighQulityTabsView({super.key});

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
            return const Center(child: CommonCircleLoading());
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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.playListDetail,
                        arguments: state.playList.playlists?[index].id);
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
                              imageUrl:
                                  '${state.playList.playlists?[index].coverImgUrl}',
                              borderRadius: BorderRadius.circular(12),
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
                  ),
                );
              },
            );
          }
          return const Center(child: CommonCircleLoading());
        });
  }
}
