import 'package:ai_music/common/widgets/common_network_image.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/log_util.dart';
import '../../routes/route_helper.dart';
import '../../themes/theme_size.dart';
import '../music/bloc/music_page_bloc.dart';
import '../music/models/recommend_songs/song.dart';
import 'bloc/play_list_bloc.dart';
import 'bloc/play_list_event.dart';
import 'bloc/play_list_state.dart';

class PlayListDetailPage extends StatelessWidget {
  static const String _tag = 'PlayListDetailPage';
  const PlayListDetailPage({super.key, required this.playListId});
  final int playListId;

  @override
  Widget build(BuildContext context) {
    logd('playListId: $playListId', tag: _tag);
    context
        .read<PlayListBloc>()
        .add(RequestPlayListDetailEvent(id: playListId));
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const StatusBarPlaceHolder(),
        _buildActionBar(context),
        _buildContent(),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return SizedBox(
      height: defaultActionBarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              RouteHelper.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<PlayListBloc, PlayListState>(
      buildWhen: (previous, current) {
        return current is PlayListDetailState;
      },
      builder: (context, state) {
        if (state is RequestPlayListDetailLoading) {
          return const Expanded(
            child: Text('加载中...'),
          );
        }
        if (state is RequestPlayListDetailError) {
          return Expanded(
            child: Text('加载失败: ${state.error}'),
          );
        }
        if (state is RequestPlayListDetailSuccess) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonNetworkImage(
                    borderRadius: BorderRadius.circular(20),
                    imageUrl: state.playListDetail.playlist?.coverImgUrl ?? '',
                    width: double.infinity,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.playListDetail.playlist?.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            logd(
                                "${state.playListDetail.playlist?.tracks?.length}",
                                tag: _tag);
                            RouteHelper.popUntil(context, '/home');
                            RouteHelper.switchHomeTab(context, 1);
                            context.read<MusicPageBloc>().add(AddPlayListEvent(
                                tracks: state.playListDetail.playlist?.tracks ??
                                    []));
                          },
                          icon: const Icon(
                            Icons.play_circle,
                            size: 40,
                          )),
                      Expanded(
                          child: Text(
                              "播放全部 ${state.playListDetail.playlist?.trackCount ?? ''}")),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_sharp,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.message,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 20,
                          )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      itemCount:
                          state.playListDetail.playlist?.tracks?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var item =
                            state.playListDetail.playlist?.tracks?[index];
                        return _buildTrackItem(context, index, item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildTrackItem(BuildContext context, int index, Song? item) {
    double itemHeight = 80;
    logd('index: $index, item: ${item?.name}', tag: _tag);
    return SizedBox(
      height: itemHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${index + 1}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withAlpha(80), fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${item?.name}",
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 5,
              ),
              Text("${item?.ar?[0].name}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white.withAlpha(80))),
            ],
          ),
        ],
      ),
    );
  }
}
