import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/log_util.dart';
import '../../explore/models/play_list_detail/track.dart';
import 'music_page_repo.dart';

part 'music_page_event.dart';
part 'music_page_state.dart';

class MusicPageBloc extends Bloc<MusicPageEvent, MusicPageState> {
  static const String _tag = "MusicPageBloc";
  final MusicPageRepo repo;
  final List<Track> tracks = [];

  MusicPageBloc(this.repo) : super(MusicPageInitial()) {
    on<MusicPageInitEvent>(_onMusicPageInitEvent);
    on<AddPlayListEvent>(_onAddPlayListEvent);
  }

  void _onMusicPageInitEvent(MusicPageInitEvent event, Emitter<MusicPageState> emit) {
    emit(MusicPageInitial());
  }

  void _onAddPlayListEvent(AddPlayListEvent event, Emitter<MusicPageState> emit) {
    logd("${event.tracks.length}", tag: _tag);
    tracks.addAll(event.tracks);
    logd(tracks, tag: _tag);
    emit(AddPlayListSuccess(tracks: tracks));
  }
}
