import 'playlist.dart';

class PlayListDetail {
  int? code;
  Playlist? playlist;

  PlayListDetail({
    this.code,
    this.playlist,
  });

  factory PlayListDetail.fromJson(Map<String, dynamic> json) {
    return PlayListDetail(
      code: json['code'] as int?,
      playlist: json['playlist'] == null
          ? null
          : Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'playlist': playlist?.toJson(),
      };
}
