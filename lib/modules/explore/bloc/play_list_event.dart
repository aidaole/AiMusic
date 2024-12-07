sealed class PlayListEvent {}

class RequestHotPlayListEvent extends PlayListEvent {}

class RequestHighQualityPlayListEvent extends PlayListEvent {}

class RequestPlayListRecommendEvent extends PlayListEvent {}
