import 'data.dart';

class RecommendSongs {
  int? code;
  Data? data;

  RecommendSongs({this.code, this.data});

  factory RecommendSongs.fromJson(Map<String, dynamic> json) {
    return RecommendSongs(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data?.toJson(),
      };
}
