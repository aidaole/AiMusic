import 'package:ai_music/common/log_util.dart';

import '../../../network/dio_utils.dart';
import '../models/artiest_play_list.dart';
import '../models/artist_detail.dart';
import '../models/high_qulity_tags.dart';
import '../models/play_list_categories.dart';
import '../models/play_list_detail/play_list_detail.dart';
import '../models/play_list_high_qulity.dart';
import '../models/play_list_recommend.dart';
import '../models/top_artists.dart';

class PlayListRepo {
  static String _tag = "PlayListRepo";

  Future<PlayListCatagories> requestHotPlayList() async {
    final resp = await DioUtils.get(path: "/playlist/hot");
    if (resp != null) {
      print("API Response: $resp");
      try {
        final result = PlayListCatagories.fromJson(resp);
        return result;
      } catch (e) {
        print("JSON 解析错误: $e");
        return PlayListCatagories(tags: [], code: 0);
      }
    }
    return PlayListCatagories(tags: [], code: 0);
  }

  Future<HighQulityTags> requestHighQualityTags() async {
    final resp = await DioUtils.get(path: "/playlist/highquality/tags");
    if (resp != null) {
      return HighQulityTags.fromJson(resp);
    }
    return HighQulityTags(tags: [], code: 0);
  }

  Future<PlayListHighQulity> requestHighQualityPlayList({String cat = "全部", int limit = 10}) async {
    final resp = await DioUtils.get(
        path: "/top/playlist/highquality", queryParameters: {"cat": cat, "limit": limit});
    if (resp != null) {
      final result = PlayListHighQulity.fromJson(resp);
      return result;
    }
    return PlayListHighQulity(playlists: [], code: 0);
  }

  Future<PlayListRecommend> requestPlayListRecommend() async {
    final resp = await DioUtils.get(path: "/recommend/resource");
    if (resp != null) {
      final result = PlayListRecommend.fromJson(resp);
      return result;
    }
    return PlayListRecommend(code: 0, recommend: []);
  }

  Future<TopArtists> requestTopArtists() async {
    final resp = await DioUtils.get(path: "/top/artists");
    if (resp != null) {
      final result = TopArtists.fromJson(resp);
      return result;
    }
    return TopArtists(artists: [], code: 0);
  }

  Future<PlayListDetail> requestPlayListDetail({required int id}) async {
    final resp = await DioUtils.get(path: "/playlist/detail", queryParameters: {"id": id});
    if (resp != null) {
      final result = PlayListDetail.fromJson(resp);
      return result;
    }
    return PlayListDetail(code: 0, playlist: null);
  }

  Future<ArtistDetail> requestArtiestDetail({required int artiestId}) async {
    final resp = await DioUtils.get(path: "/artist/detail", queryParameters: {"id": artiestId});
    logd("requestArtiestDetail-> $resp", tag: _tag);
    if (resp != null) {
      final result = ArtistDetail.fromJson(resp);
      return result;
    }
    return ArtistDetail(code: 0, message: "失败", data: Data());
  }

  Future<ArtiestPlayList> requestArtistPlayList({required int artistId}) async {
    final resp = await DioUtils.get(path: "/artist/songs", queryParameters: {"id": artistId});
    if (resp != null) {
      return ArtiestPlayList.fromJson(resp);
    }
    return ArtiestPlayList(songs: List.empty(), more: false, total: 0, code: 0);
  }
}
