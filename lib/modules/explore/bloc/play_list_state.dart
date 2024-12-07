import '../models/play_list_categories.dart';
import '../models/play_list_high_qulity.dart';
import '../models/play_list_recommend.dart';

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

final class RequestHighQualityPlayListLoading extends PlayListState {}

final class RequestHighQualityPlayListSuccess extends PlayListState {
  final PlayListHighQulity playList;

  RequestHighQualityPlayListSuccess(this.playList);
}

final class RequestHighQualityPlayListError extends PlayListState {
  final String error;

  RequestHighQualityPlayListError(this.error);
}

final class RequestPlayListRecommendLoading extends PlayListState {}

final class RequestPlayListRecommendSuccess extends PlayListState {
  final PlayListRecommend playList;

  RequestPlayListRecommendSuccess(this.playList);
}

final class RequestPlayListRecommendError extends PlayListState {
  final String error;

  RequestPlayListRecommendError(this.error);
}
