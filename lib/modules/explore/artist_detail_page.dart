import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/log_util.dart';
import '../../common/widgets/common_network_image.dart';
import '../../routes/route_helper.dart';
import '../../themes/theme_size.dart';
import '../music/bloc/music_page_bloc.dart';
import '../music/models/recommend_songs/song.dart';
import 'bloc/play_list_bloc.dart';
import 'bloc/play_list_event.dart';
import 'bloc/play_list_state.dart';

class ArtistDetailPage extends StatelessWidget {
  static const String _tag = 'ArtistDetailPage';

  const ArtistDetailPage({super.key, required this.artiestId});

  final int artiestId;

  @override
  Widget build(BuildContext context) {
    logd('artiestId: $artiestId', tag: _tag);
    context.read<PlayListBloc>().add(RequestArtistsDetailEvent(artistId: artiestId));
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
        return current is ArtiestDetailState;
      },
      builder: (context, state) {
        if (state is RequestArtistDetailLoading) {
          return const Expanded(
            child: Text('加载中...'),
          );
        }
        if (state is RequestArtiestDetailFailed) {
          return Expanded(
            child: Text('加载失败: ${state.error}'),
          );
        }
        if (state is RequestArtiestDetailSuccess) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonNetworkImage(
                    borderRadius: BorderRadius.circular(20),
                    imageUrl: state.artiestDetail.data?.artist?.cover ?? '',
                    width: double.infinity,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.artiestDetail.data?.artist?.name ?? '未知',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(state.artiestDetail.data?.artist?.briefDesc ?? '未知',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            RouteHelper.popUntil(context, '/home');
                            RouteHelper.switchHomeTab(context, 1);
                            context.read<MusicPageBloc>().add(AddPlayListEvent(
                                tracks: state.artiestDetail.playlist?.songs ?? []));
                          },
                          icon: const Icon(
                            Icons.play_circle,
                            size: 40,
                          )),
                      Expanded(child: Text("播放全部 ${state.artiestDetail.playlist?.total ?? ''}")),
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
                      itemCount: state.artiestDetail.playlist?.songs?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var item = state.artiestDetail.playlist?.songs?[index];
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
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white.withAlpha(80), fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${item?.name}", style: Theme.of(context).textTheme.bodyLarge),
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
