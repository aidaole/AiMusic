import 'package:ai_music/modules/music/models/recommend_songs/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../common/log_util.dart';
import '../../common/widgets/common_circle_loading.dart';
import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import 'bloc/music_page_bloc.dart';

class MusicPage extends StatefulWidget {
  static final Map<String, Color> _colorCache = {};

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
          builder: (context, state) {
            logd("MusicPage state: $state", tag: "MusicPage");
            if (state is AddPlayListSuccess) {
              return _buildMusicListWidget(context);
            }
            if (state is MusicPageLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonCircleLoading(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("加载中..."),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Column(
          children: [
            _buildStatusBar(context),
            _buildActionBar(context),
          ],
        )
      ],
    );
  }

  _buildMusicListWidget(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final songs = context.read<MusicPageBloc>().songs;
        final song = songs[index];
        return _buildMusicInfoItemWidget(context, index, song);
      },
    );
  }

  _buildMusicInfoItemWidget(BuildContext context, int index, Song song) {
    return FutureBuilder<Color>(
      future: _extractDominantColor(song.al?.picUrl),
      builder: (context, snapshot) {
        final backgroundColor = snapshot.data ?? Colors.black;

        return Container(
          color: backgroundColor,
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
        );
      },
    );
  }

  Padding _buildMusicPicWidget(BuildContext context, String? picUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(picUrl ?? ""), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
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
    const iconSize = 35.0;
    final track = context.read<MusicPageBloc>().songs[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${track.name}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${track.ar?[0].name}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
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
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "0:00",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                    trackHeight: 2.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6.0,
                    ),
                  ),
                  child: Slider(
                    value: 0.0,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      // TODO: 处理进度条拖动
                    },
                  ),
                ),
              ),
              Text(
                "3:45",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildStatusBar(BuildContext context) {
    return SizedBox(height: defaultStatusBarHeight.toDouble());
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu, size: iconSize)),
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

  Future<Color> _extractDominantColor(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Colors.black;
    }

    // 检查缓存
    if (MusicPage._colorCache.containsKey(imageUrl)) {
      return MusicPage._colorCache[imageUrl]!;
    }

    try {
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
        size: const Size(200, 200),
      );

      final color = paletteGenerator.vibrantColor?.color ??
          paletteGenerator.dominantColor?.color ??
          Colors.black;

      // 存入缓存
      MusicPage._colorCache[imageUrl] = color;
      return color;
    } catch (e) {
      logd('提取颜色失败: $e');
      return Colors.black;
    }
  }
}
