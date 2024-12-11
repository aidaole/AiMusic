import 'package:ai_music/common/widgets/common_network_image.dart';
import 'package:ai_music/modules/music/models/recommend_songs/song.dart';
import 'package:ai_music/widgets/load_error_widget.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/log_util.dart';
import '../../common/widgets/common_circle_loading.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'bloc/music_page_bloc.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  static const String _tag = "MusicPage";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        LogUtil.i("MusicPage initState called", tag: _tag);
        context.read<MusicPageBloc>().add(MusicPageInitEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildMainContent(context),
    );
  }

  _buildMainContent(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MusicPageBloc, MusicPageState>(
          buildWhen: (previous, current) =>
              current is AddPlayListSuccess || current is MusicPageLoading,
          builder: (context, state) {
            logd("MusicPage state: $state", tag: "MusicPage");
            if (state is AddPlayListSuccess) {
              return _buildMusicListWidget(context);
            }
            if (state is MusicPageLoading) {
              return const Center(child: CommonCircleLoading());
            }
            return const LoadErrorWidget();
          },
        ),
        Column(
          children: [
            const StatusBarPlaceHolder(),
            _buildActionBar(context),
          ],
        )
      ],
    );
  }

  _buildMusicListWidget(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        logd("当前滑动到第$index个", tag: _tag);
        context
            .read<MusicPageBloc>()
            .add(MusicPageChangeIndexEvent(index: index));
      },
      itemCount: context.read<MusicPageBloc>().songs.length,
      itemBuilder: (context, index) {
        final songs = context.read<MusicPageBloc>().songs;
        final song = songs[index];
        return _buildMusicInfoItemWidget(context, index, song);
      },
    );
  }

  _buildMusicInfoItemWidget(BuildContext context, int index, Song song) {
    return Stack(
      children: [
        // 背景颜色层
        Container(
          color: song.color ?? defaultBgColor,
          width: double.infinity,
          height: double.infinity,
        ),
        // 内容层
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildMusicPicWidget(context, song.al?.picUrl),
              const SizedBox(height: 40),
              _buildMusicLyricWidget(context),
              const Spacer(),
              _buildMusicControlWidget(context, index),
              SizedBox(height: defaultBottomNavigationBarHeight),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildMusicPicWidget(BuildContext context, String? picUrl) {
    double size = MediaQuery.of(context).size.width - 60;
    logd("picUrl: $picUrl", tag: _tag);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: CommonNetworkImage(
            imageUrl: picUrl ?? "",
            width: size,
            height: size,
            fit: BoxFit.cover),
      ),
    );
  }

  _buildMusicLyricWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'And I don\'t want to miss a thing, I will never miss a thing',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _buildMusicControlWidget(BuildContext context, int index) {
    final song = context.read<MusicPageBloc>().songs[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${song.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${song.ar?[0].name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildControllItems(),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        _buildSeekBarWidget(context, song),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Row _buildControllItems() {
    const iconSize = 30.0;
    return const Row(
      children: [
        Icon(Icons.favorite_sharp, size: iconSize),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.message, size: iconSize),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.share, size: iconSize),
        Spacer(),
        Icon(Icons.thumb_up, size: iconSize - 10),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.more_vert, size: iconSize - 10),
      ],
    );
  }

  _buildActionBar(BuildContext context) {
    const iconSize = 25.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: defaultActionBarHeight.toDouble(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.menu, size: iconSize)),
            Text(
              "模式选择",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            const Icon(Icons.search, size: iconSize),
          ],
        ),
      ),
    );
  }

  _buildSeekBarWidget(BuildContext context, Song song) {
    return SizedBox(
        height: 80,
        width: double.infinity,
        child: StreamBuilder<Duration?>(
          stream: context.read<MusicPageBloc>().musicService.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final duration =
                context.read<MusicPageBloc>().musicService.duration ??
                    Duration.zero;
            return Slider(
              label: null,
              activeColor: Colors.white.withOpacity(0.8),
              inactiveColor: Colors.white.withOpacity(0.2),
              thumbColor: Colors.white,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (value) {
                context
                    .read<MusicPageBloc>()
                    .musicService
                    .seek(Duration(seconds: value.toInt()));
              },
            );
          },
        ));
  }
}
