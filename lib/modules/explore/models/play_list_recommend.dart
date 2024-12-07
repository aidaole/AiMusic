class PlayListRecommend {
  int? code;
  bool? featureFirst;
  bool? haveRcmdSongs;
  List<Recommend>? recommend;

  PlayListRecommend({
    this.code,
    this.featureFirst,
    this.haveRcmdSongs,
    this.recommend,
  });

  factory PlayListRecommend.fromJson(Map<String, dynamic> json) {
    return PlayListRecommend(
      code: json['code'] as int?,
      featureFirst: json['featureFirst'] as bool?,
      haveRcmdSongs: json['haveRcmdSongs'] as bool?,
      recommend: (json['recommend'] as List<dynamic>?)
          ?.map((e) => Recommend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'featureFirst': featureFirst,
        'haveRcmdSongs': haveRcmdSongs,
        'recommend': recommend?.map((e) => e.toJson()).toList(),
      };
}

class Recommend {
  int? id;
  int? type;
  String? name;
  String? picUrl;

  Recommend({
    this.id,
    this.type,
    this.name,
    this.picUrl,
  });

  factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
        id: json['id'] as int?,
        type: json['type'] as int?,
        name: json['name'] as String?,
        picUrl: json['picUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'picUrl': picUrl,
      };
}
