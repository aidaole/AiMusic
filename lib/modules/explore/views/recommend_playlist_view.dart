import 'package:ai_music/common/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/common_circle_loading.dart';
import '../../../common/widgets/common_network_image.dart';
import '../../../routes/app_routes.dart';
import '../bloc/play_list_bloc.dart';
import '../bloc/play_list_event.dart';
import '../bloc/play_list_state.dart';

class RecommendPlaylistView extends StatefulWidget {
  const RecommendPlaylistView({super.key});

  @override
  State<RecommendPlaylistView> createState() => _RecommendPlaylistViewState();
}

class _RecommendPlaylistViewState extends State<RecommendPlaylistView> {
  final String _tag = "RecommendPlaylistView";

  @override
  Widget build(BuildContext context) {
    return _buildRecommendPlayListBloc(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PlayListBloc>().add(RequestPlayListRecommendEvent());
      }
    });
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
              logd("state: $state", tag: _tag);
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
}
