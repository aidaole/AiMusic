import 'package:ai_music/common/log_util.dart';
import 'package:bloc/bloc.dart';

import '../repos/play_list_repo.dart';
import 'play_list_event.dart';
import 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  final PlayListRepo playListRepo;

  PlayListBloc(this.playListRepo) : super(PlayListInitial()) {
    on<RequestHotPlayListEvent>((event, emit) {
      _onRequestHotPlayListEvent(event, emit);
    });
  }

  void _onRequestHotPlayListEvent(
      RequestHotPlayListEvent event, Emitter<PlayListState> emit) async {
    try {
      final playListCatagories = await playListRepo.requestHotPlayList();
      LogUtil.i("playListCatagories: ${playListCatagories.tags.length}");
      if (!emit.isDone) {
        emit(RequestHotPlayListSuccess(playListCatagories));
      }
    } catch (e) {
      LogUtil.e(e);
      emit(RequestHotPlayListError(e.toString()));
    }
  }
}
