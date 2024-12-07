class PlayListHighQulity {
  List<Playlist>? playlists;
  int? code;

  PlayListHighQulity({
    this.playlists,
    this.code,
  });

  factory PlayListHighQulity.fromJson(Map<String, dynamic> json) {
    return PlayListHighQulity(
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'playlists': playlists?.map((e) => e.toJson()).toList(),
        'code': code,
      };
}

class Playlist {
  String? name;
  int? id;
  String? coverImgUrl;

  Playlist({
    this.name,
    this.id,
    this.coverImgUrl,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        name: json['name'] as String?,
        id: json['id'] as int?,
        coverImgUrl: json['coverImgUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'coverImgUrl': coverImgUrl,
      };
}
