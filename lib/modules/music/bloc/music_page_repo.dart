import 'package:ai_music/modules/music/models/recommend_songs/song.dart';

import '../../../common/log_util.dart';
import '../../../network/dio_utils.dart';
import '../models/recommend_songs/recommend_songs.dart';
import '../models/song_detail/song_detail.dart';

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

  Future<SongDetail> getSongDetail(int? id) async {
    final resp = await DioUtils.get(path: "/song/url/v1?id=$id&level=standard");
    if (resp != null) {
      return SongDetail.fromJson(resp);
    }
    return SongDetail();
  }
}
