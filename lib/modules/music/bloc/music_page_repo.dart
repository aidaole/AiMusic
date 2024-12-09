import 'package:ai_music/modules/music/models/recommend_songs/song.dart';

import '../../../common/log_util.dart';
import '../../../network/dio_utils.dart';
import '../models/recommend_songs/recommend_songs.dart';

class MusicPageRepo {
  static const String _tag = "MusicPageRepo";
  Future<List<Song>> getRecommendSongs() async {
    logd("getRecommendSongs", tag: _tag);
    final resp = await DioUtils.get(path: "/recommend/songs");
    if (resp != null) {
      logd("getRecommendSongs resp: $resp", tag: _tag);
      final result = RecommendSongs.fromJson(resp);
      return result.data?.dailySongs ?? [];
    }
    return [];
  }
}
