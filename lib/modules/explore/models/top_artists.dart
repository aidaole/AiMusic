class TopArtists {
  int? code;
  bool? more;
  List<Artist>? artists;

  TopArtists({this.code, this.more, this.artists});

  factory TopArtists.fromJson(Map<String, dynamic> json) => TopArtists(
        code: json['code'] as int?,
        more: json['more'] as bool?,
        artists: (json['artists'] as List<dynamic>?)
            ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'more': more,
        'artists': artists?.map((e) => e.toJson()).toList(),
      };
}

class Artist {
  String? name;
  int? id;
  String? picUrl;
  String? img1v1Url;

  Artist({
    this.name,
    this.id,
    this.picUrl,
    this.img1v1Url,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        name: json['name'] as String?,
        id: json['id'] as int?,
        picUrl: json['picUrl'] as String?,
        img1v1Url: json['img1v1Url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'picUrl': picUrl,
        'img1v1Url': img1v1Url,
      };
}
