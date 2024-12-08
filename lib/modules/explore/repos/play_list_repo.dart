import 'package:ai_music/modules/explore/models/high_qulity_tags.dart';
import 'package:ai_music/modules/explore/models/play_list_categories.dart';
import 'package:ai_music/modules/explore/models/play_list_high_qulity.dart';
import 'package:ai_music/network/dio_utils.dart';

import '../models/play_list_recommend.dart';

class PlayListRepo {
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

  Future<PlayListHighQulity> requestHighQualityPlayList(
      {String cat = "全部", int limit = 10}) async {
    final resp = await DioUtils.get(
        path: "/top/playlist/highquality",
        queryParameters: {"cat": cat, "limit": limit});
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
}