sealed class PlayListEvent {}

class RequestHotPlayListEvent extends PlayListEvent {}

class RequestHighQualityPlayListEvent extends PlayListEvent {
  final String cat;
  final int limit;

  RequestHighQualityPlayListEvent({this.cat = "全部", this.limit = 10});
}

class RequestPlayListRecommendEvent extends PlayListEvent {}

class RequestHighQualityTagsEvent extends PlayListEvent {}

class RequestTopArtistsEvent extends PlayListEvent {}

class RequestArtistsDetailEvent extends PlayListEvent {
  final int artistId;

  RequestArtistsDetailEvent({required this.artistId});
}

class RequestPlayListDetailEvent extends PlayListEvent {
  final int id;

  RequestPlayListDetailEvent({required this.id});
}

class RequestHighQualityPlayListLoadMoreEvent extends PlayListEvent {
  final String cat;
  RequestHighQualityPlayListLoadMoreEvent({required this.cat});
}
