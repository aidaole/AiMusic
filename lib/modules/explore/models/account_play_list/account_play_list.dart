import 'playlist.dart';

class AccountPlayList {
  bool? more;
  List<Playlist>? playlist;
  int? code;

  AccountPlayList({this.more, this.playlist, this.code});

  factory AccountPlayList.fromJson(Map<String, dynamic> json) {
    return AccountPlayList(
      more: json['more'] as bool?,
      playlist: (json['playlist'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'more': more,
        'playlist': playlist?.map((e) => e.toJson()).toList(),
        'code': code,
      };
}
