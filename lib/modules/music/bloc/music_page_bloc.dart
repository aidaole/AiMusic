import 'package:ai_music/modules/music/models/recommend_songs/song.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/log_util.dart';
import '../../explore/repos/play_list_repo.dart';
import 'music_page_repo.dart';

part 'music_page_event.dart';
part 'music_page_state.dart';

class MusicPageBloc extends Bloc<MusicPageEvent, MusicPageState> {
  static const String _tag = "MusicPageBloc";
  final MusicPageRepo repo;
  final PlayListRepo playlistRepo;
  final List<Song> songs = [];

  MusicPageBloc(this.repo, this.playlistRepo) : super(MusicPageInitial()) {
    on<MusicPageInitEvent>(_onMusicPageInitEvent);
    on<AddPlayListEvent>(_onAddPlayListEvent);
  }

  void _onMusicPageInitEvent(MusicPageInitEvent event, Emitter<MusicPageState> emit) async {
    logd("MusicPageInitEvent", tag: _tag);
    if (songs.isNotEmpty) {
      emit(AddPlayListSuccess(songs: songs));
    } else {
      emit(MusicPageLoading());
      List<Song> newSongs = await repo.getRecommendSongs();
      songs.addAll(newSongs);
      emit(AddPlayListSuccess(songs: songs));
    }
  }

  void _onAddPlayListEvent(AddPlayListEvent event, Emitter<MusicPageState> emit) {
    logd("${event.tracks.length}", tag: _tag);
    songs.insertAll(0, event.tracks);
    logd(songs, tag: _tag);
    emit(AddPlayListSuccess(songs: songs));
  }
}
