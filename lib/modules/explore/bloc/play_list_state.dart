import 'package:ai_music/modules/explore/models/artist_detail.dart';

import '../models/high_qulity_tags.dart';
import '../models/play_list_categories.dart';
import '../models/play_list_detail/play_list_detail.dart';
import '../models/play_list_high_qulity.dart';
import '../models/play_list_recommend.dart';
import '../models/top_artists.dart';

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

final class RequestHighQualityPlayListLoading extends PlayListState {
  final String cat;

  RequestHighQualityPlayListLoading(this.cat);
}

final class RequestHighQualityPlayListSuccess extends PlayListState {
  final PlayListHighQulity playList;
  final String cat;

  RequestHighQualityPlayListSuccess(this.playList, this.cat);
}

final class RequestHighQualityPlayListError extends PlayListState {
  final String error;
  final String cat;

  RequestHighQualityPlayListError(this.error, this.cat);
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

final class RequestHighQualityTagsLoading extends PlayListState {}

final class RequestHighQualityTagsSuccess extends PlayListState {
  final HighQulityTags tags;

  RequestHighQualityTagsSuccess(this.tags);
}

final class RequestHighQualityTagsError extends PlayListState {
  final String error;

  RequestHighQualityTagsError(this.error);
}

final class RequestTopArtistsLoading extends PlayListState {}

final class RequestTopArtistsSuccess extends PlayListState {
  final TopArtists topArtists;

  RequestTopArtistsSuccess(this.topArtists);
}

final class RequestTopArtistsError extends PlayListState {
  final String error;

  RequestTopArtistsError(this.error);
}

class PlayListDetailState extends PlayListState {}

final class RequestPlayListDetailLoading extends PlayListDetailState {
  final int id;

  RequestPlayListDetailLoading(this.id);
}

final class RequestPlayListDetailSuccess extends PlayListDetailState {
  final PlayListDetail playListDetail;

  RequestPlayListDetailSuccess(this.playListDetail);
}

final class RequestPlayListDetailError extends PlayListDetailState {
  final String error;

  RequestPlayListDetailError(this.error);
}

// 歌手详情
class ArtiestDetailState extends PlayListState {}

final class RequestArtistDetailLoading extends ArtiestDetailState {}

final class RequestArtiestDetailSuccess extends ArtiestDetailState {
  final ArtistDetail artiestDetail;

  RequestArtiestDetailSuccess({
    required this.artiestDetail,
  });
}

final class RequestArtiestDetailFailed extends ArtiestDetailState {
  final String error;

  RequestArtiestDetailFailed({
    required this.error,
  });
}

class RequestHighQualityPlayListLoadMoreSuccess extends PlayListState {
  final PlayListHighQulity playList;
  final String cat;
  final bool isLoadingMore;

  RequestHighQualityPlayListLoadMoreSuccess({
    required this.playList,
    required this.cat,
    this.isLoadingMore = false,
  });
}
