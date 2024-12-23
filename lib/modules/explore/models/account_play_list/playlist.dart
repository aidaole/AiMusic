class Playlist {
  int? userId;
  String? coverImgUrl;
  String? description;
  String? name;
  int? id;
  int? trackCount;

  Playlist({
    this.userId,
    this.coverImgUrl,
    this.description,
    this.name,
    this.id,
    this.trackCount,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        userId: json['userId'] as int?,
        coverImgUrl: json['coverImgUrl'] as String?,
        description: json['description'] as String?,
        name: json['name'] as String?,
        id: json['id'] as int?,
        trackCount: json['trackCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'coverImgUrl': coverImgUrl,
        'description': description,
        'name': name,
        'id': id,
        'trackCount': trackCount,
      };
}
