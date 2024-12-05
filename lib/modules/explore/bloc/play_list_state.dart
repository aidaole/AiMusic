import 'package:ai_music/modules/explore/models/play_list_categories.dart';

class PlayListState {}

final class PlayListInitial extends PlayListState {}

final class RequestHotPlayListLoading extends PlayListState {}

final class RequestHotPlayListSuccess extends PlayListState {
  final PlayListCatagories playList;

  RequestHotPlayListSuccess(this.playList);
}

final class RequestHotPlayListError extends PlayListState {
  final String error;

  RequestHotPlayListError(this.error);
}
