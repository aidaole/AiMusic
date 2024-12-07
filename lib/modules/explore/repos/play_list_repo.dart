import 'package:ai_music/modules/explore/models/play_list_categories.dart';
import 'package:ai_music/modules/explore/models/play_list_high_qulity.dart';
import 'package:ai_music/network/dio_utils.dart';

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

  Future<PlayListHighQulity> requestHighQualityPlayList() async {
    final resp = await DioUtils.get(path: "/top/playlist/highquality");
    if (resp != null) {
      final result = PlayListHighQulity.fromJson(resp);
      return result;
    }
    return PlayListHighQulity(playlists: [], code: 0);
  }
}
