import 'dart:math';
import 'dart:ui';

import 'package:ai_music/modules/music/models/recommend_songs/song.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/log_util.dart';
import '../../explore/repos/play_list_repo.dart';
import '../models/song_detail/song_detail.dart';
import '../music_service.dart';
import 'music_page_repo.dart';

part 'music_page_event.dart';
part 'music_page_state.dart';

class MusicPageBloc extends Bloc<MusicPageEvent, MusicPageState> {
  static const String _tag = "MusicPageBloc";
  final MusicPageRepo repo;
  final PlayListRepo playlistRepo;
  final List<Song> songs = [];
  final MusicService musicService = MusicService();

  MusicPageBloc(this.repo, this.playlistRepo) : super(MusicPageInitial()) {
    on<MusicPageInitEvent>(_onMusicPageInitEvent);
    on<AddPlayListEvent>(_onAddPlayListEvent);
    on<MusicPageChangeIndexEvent>(_onMusicPageChangeIndexEvent);
  }

  void _onMusicPageInitEvent(
      MusicPageInitEvent event, Emitter<MusicPageState> emit) async {
    logd("MusicPageInitEvent", tag: _tag);
    if (songs.isNotEmpty) {
      emit(AddPlayListSuccess(songs: songs));
      _onMusicPageChangeIndexEvent(MusicPageChangeIndexEvent(index: 0), emit);
    } else {
      emit(MusicPageLoading());
      List<Song> newSongs = await repo.getRecommendSongs();
      await _addSongsColor(newSongs);
      songs.addAll(newSongs);
      emit(AddPlayListSuccess(songs: songs));
      _onMusicPageChangeIndexEvent(MusicPageChangeIndexEvent(index: 0), emit);
    }
  }

  Future<void> _addSongsColor(List<Song> newSongs) async {
    // 如果图片URL为空,生成一个接近defaultBgColor的随机颜色
    for (var song in newSongs) {
      final Random random = Random();
      const Color baseColor = defaultBgColor;
      const int variance = 200; // 颜色变化范围
      // 在基础颜色的RGB值上添加随机偏移
      int r = (baseColor.red + random.nextInt(variance) - variance ~/ 2)
          .clamp(0, 255);
      int g = (baseColor.green + random.nextInt(variance) - variance ~/ 2)
          .clamp(0, 255);
      int b = (baseColor.blue + random.nextInt(variance) - variance ~/ 2)
          .clamp(0, 255);

      song.color = Color.fromRGBO(r, g, b, 1.0).withAlpha(80);
    }
  }

  void _onAddPlayListEvent(
      AddPlayListEvent event, Emitter<MusicPageState> emit) async {
    logd("${event.tracks.length}", tag: _tag);
    final newSongs = event.tracks;
    await _addSongsColor(newSongs);
    songs.insertAll(0, newSongs);
    logd(songs, tag: _tag);
    emit(AddPlayListSuccess(songs: songs));
    _onMusicPageChangeIndexEvent(MusicPageChangeIndexEvent(index: 0), emit);
  }

  void _onMusicPageChangeIndexEvent(
      MusicPageChangeIndexEvent event, Emitter<MusicPageState> emit) async {
    try {
      logd("当前滑动到第${event.index}个", tag: _tag);
      final song = songs[event.index];
      final songDetail = await repo.getSongDetail(song.id);
      String currentMusicUrl = songDetail.data?[0].url ?? "";
      if (!currentMusicUrl.startsWith("https")) {
        currentMusicUrl = currentMusicUrl.replaceFirst("http", "https");
      }
      songDetail.data?[0].url = currentMusicUrl;
      logd(songDetail.toString(), tag: _tag);

      musicService.init(currentMusicUrl);
      if (musicService.isPlaying) {
        musicService.play();
      }
    } catch (e) {
      logd("获取歌曲详情失败: $e", tag: _tag);
    }
  }
}
