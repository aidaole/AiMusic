import 'track.dart';

class Playlist {
  int? id;
  String? name;
  String? coverImgUrl;
  int? userId;
  int? createTime;
  int? status;
  int? trackCount;
  int? playCount;
  int? subscribedCount;
  String? description;
  bool? subscribed;
  List<Track>? tracks;

  Playlist({
    this.id,
    this.name,
    this.coverImgUrl,
    this.userId,
    this.createTime,
    this.status,
    this.trackCount,
    this.playCount,
    this.subscribedCount,
    this.description,
    this.subscribed,
    this.tracks,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json['id'] as int?,
        name: json['name'] as String?,
        coverImgUrl: json['coverImgUrl'] as String?,
        userId: json['userId'] as int?,
        createTime: json['createTime'] as int?,
        status: json['status'] as int?,
        trackCount: json['trackCount'] as int?,
        playCount: json['playCount'] as int?,
        subscribedCount: json['subscribedCount'] as int?,
        description: json['description'] as String?,
        tracks: (json['tracks'] as List<dynamic>?)
            ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coverImgUrl': coverImgUrl,
        'userId': userId,
        'createTime': createTime,
        'status': status,
        'trackCount': trackCount,
        'playCount': playCount,
        'subscribedCount': subscribedCount,
        'description': description,
        'subscribed': subscribed,
        'tracks': tracks?.map((e) => e.toJson()).toList(),
      };
}
