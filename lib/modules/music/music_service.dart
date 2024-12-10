import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../../common/log_util.dart';

class MusicService {
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;
  MusicService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final String _tag = "MusicService";

  Stream<bool> get playingStream => _audioPlayer.playerStateStream.map((state) => state.playing);
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Duration? get duration => _audioPlayer.duration;
  bool get isPlaying => _audioPlayer.playing;

  Future<void> init(String url) async {
    logd("初始化音频: $url", tag: _tag);
    if (url.isEmpty) return;

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    try {
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      logd('音频初始化错误: $e', tag: _tag);
      rethrow;
    }
  }

  Future<void> play() => _audioPlayer.play();
  Future<void> pause() => _audioPlayer.pause();
  Future<void> seek(Duration position) => _audioPlayer.seek(position);
  Future<void> stop() => _audioPlayer.stop();
  void dispose() => _audioPlayer.dispose();
}
