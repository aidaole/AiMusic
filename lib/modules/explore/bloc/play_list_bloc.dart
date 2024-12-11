import 'package:ai_music/common/log_util.dart';
import 'package:ai_music/modules/explore/models/play_list_high_qulity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/play_list_repo.dart';
import 'play_list_event.dart';
import 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  static const String _tag = "PlayListBloc";

  final PlayListRepo playListRepo;

  // 添加一个缓存Map
  final Map<String, PlayListHighQulity> _playListCache = {};

  PlayListBloc({required this.playListRepo}) : super(PlayListInitial()) {
    on<RequestHotPlayListEvent>(_onRequestHotPlayListEvent);
    on<RequestHighQualityTagsEvent>(_onRequestHighQualityTagsEvent);
    on<RequestHighQualityPlayListEvent>(_onRequestHighQualityPlayListEvent);
    on<RequestPlayListRecommendEvent>(_onRequestPlayListRecommendEvent);
    on<RequestTopArtistsEvent>(_onRequestTopArtistsEvent);
    on<RequestArtistsDetailEvent>(_onRequestArtistsPlayListEvent);
    on<RequestPlayListDetailEvent>(_onRequestPlayListDetailEvent);
  }

  void _onRequestHotPlayListEvent(
      RequestHotPlayListEvent event, Emitter<PlayListState> emit) async {
    LogUtil.i("requestHotPlayListEvent", tag: _tag);
    try {
      emit(RequestHotPlayListLoading());
      final playListCatagories = await playListRepo.requestHotPlayList();
      LogUtil.i("playListCatagories: ${playListCatagories.tags.length}", tag: _tag);
      emit(RequestHotPlayListSuccess(playListCatagories));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestHotPlayListError(e.toString()));
    }
  }

  void _onRequestHighQualityPlayListEvent(
      RequestHighQualityPlayListEvent event, Emitter<PlayListState> emit) async {
    LogUtil.i("requestHighQualityPlayListEvent: $event", tag: _tag);
    // 如果缓存中已经有数据，直接使用缓存
    if (_playListCache.containsKey(event.cat)) {
      emit(RequestHighQualityPlayListSuccess(
        _playListCache[event.cat]!,
        event.cat,
      ));
      return;
    }

    // 如果缓存中没有，才发送loading和请求新数据
    emit(RequestHighQualityPlayListLoading(event.cat));
    try {
      final playListHighQulity =
          await playListRepo.requestHighQualityPlayList(cat: event.cat, limit: event.limit);
      LogUtil.i("playListHighQulity: ${playListHighQulity.playlists?.length}", tag: _tag);
      // 将结果存入缓存
      _playListCache[event.cat] = playListHighQulity;
      emit(RequestHighQualityPlayListSuccess(playListHighQulity, event.cat));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestHighQualityPlayListError(e.toString(), event.cat));
    }
  }

  void _onRequestPlayListRecommendEvent(
      RequestPlayListRecommendEvent event, Emitter<PlayListState> emit) async {
    LogUtil.i("requestPlayListRecommendEvent", tag: _tag);
    try {
      emit(RequestPlayListRecommendLoading());
      final playListRecommend = await playListRepo.requestPlayListRecommend();
      LogUtil.i("playListRecommend: ${playListRecommend.recommend?.length}", tag: _tag);
      emit(RequestPlayListRecommendSuccess(playListRecommend));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestPlayListRecommendError(e.toString()));
    }
  }

  void _onRequestHighQualityTagsEvent(
      RequestHighQualityTagsEvent event, Emitter<PlayListState> emit) async {
    LogUtil.i("requestHighQualityTagsEvent", tag: _tag);
    try {
      emit(RequestHighQualityTagsLoading());
      final highQualityTags = await playListRepo.requestHighQualityTags();
      emit(RequestHighQualityTagsSuccess(highQualityTags));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestHighQualityTagsError(e.toString()));
    }
  }

  void _onRequestTopArtistsEvent(RequestTopArtistsEvent event, Emitter<PlayListState> emit) async {
    try {
      emit(RequestTopArtistsLoading());
      final topArtists = await playListRepo.requestTopArtists();
      emit(RequestTopArtistsSuccess(topArtists));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestTopArtistsError(e.toString()));
    }
  }

  void _onRequestPlayListDetailEvent(
      RequestPlayListDetailEvent event, Emitter<PlayListState> emit) async {
    LogUtil.i("requestPlayListDetailEvent: $event", tag: _tag);
    try {
      emit(RequestPlayListDetailLoading(event.id));
      final playListDetail = await playListRepo.requestPlayListDetail(id: event.id);
      emit(RequestPlayListDetailSuccess(playListDetail));
    } catch (e, stackTrace) {
      LogUtil.e("错误详情: $e\n$stackTrace", tag: _tag);
      emit(RequestPlayListDetailError(e.toString()));
    }
  }

  void _onRequestArtistsPlayListEvent(
      RequestArtistsDetailEvent event, Emitter<PlayListState> emit) async {
    logd("_onRequestArtistsPlayListEvent", tag: _tag);
    try {
      emit(RequestArtistDetailLoading());
      final artiestDetail = await playListRepo.requestArtiestDetail(artiestId: event.artistId);
      emit(RequestArtiestDetailSuccess(artiestDetail: artiestDetail));
    } catch (e) {
      emit(RequestArtiestDetailFailed(error: e.toString()));
    }
  }
}
