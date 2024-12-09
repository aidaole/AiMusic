import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // 配置音频会话
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    // 监听播放错误
    _audioPlayer.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        debugPrint('播放错误: $e');
        debugPrint('错误堆栈: $stackTrace');
      },
    );

    // 初始化音频源
    try {
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
              'https://m10.music.126.net/20241209222541/1fcd71f576aa880723885990fa43cd4d/ymusic/c48c/fb99/1950/a0634034446f904929e37dc2686ba91b.mp3'),
        ),
      );

      // 监听播放状态
      _audioPlayer.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });
    } on PlayerException catch (e) {
      debugPrint('音频加载错误: ${e.message}');
      debugPrint('错误代码: ${e.code}');
    } on PlayerInterruptedException catch (e) {
      debugPrint('播放被中断: $e');
    } catch (e) {
      debugPrint('发生其他错误: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (_isPlaying) {
              _audioPlayer.pause();
            } else {
              _audioPlayer.play();
            }
          },
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        // 添加进度条
        Expanded(
          child: StreamBuilder<Duration?>(
            stream: _audioPlayer.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = _audioPlayer.duration ?? Duration.zero;
              return Slider(
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  _audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
