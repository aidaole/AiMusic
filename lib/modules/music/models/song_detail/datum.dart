class Datum {
  int? id;
  String? url;
  int? size;
  String? md5;
  String? type;
  String? level;
  int? time;
  String? musicId;

  Datum({
    this.id,
    this.url,
    this.size,
    this.md5,
    this.type,
    this.level,
    this.time,
    this.musicId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        url: json['url'] as String?,
        size: json['size'] as int?,
        md5: json['md5'] as String?,
        type: json['type'] as String?,
        level: json['level'] as String?,
        time: json['time'] as int?,
        musicId: json['musicId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'size': size,
        'md5': md5,
        'type': type,
        'level': level,
        'time': time,
        'musicId': musicId,
      };
}
