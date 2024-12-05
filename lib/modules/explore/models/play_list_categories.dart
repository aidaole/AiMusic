class PlayListCatagories {
  final List<PlayListTag> tags;
  final int code;

  PlayListCatagories({
    required this.tags,
    required this.code,
  });

  factory PlayListCatagories.fromJson(Map<String, dynamic> json) {
    return PlayListCatagories(
      tags: (json['tags'] as List).map((tag) => PlayListTag.fromJson(tag)).toList(),
      code: json['code'],
    );
  }
}

class PlayListTag {
  final int usedCount;
  final bool hot;
  final int createTime;
  final String name;
  final int id;

  PlayListTag({
    required this.usedCount,
    required this.hot,
    required this.createTime,
    required this.name,
    required this.id,
  });

  factory PlayListTag.fromJson(Map<String, dynamic> json) {
    return PlayListTag(
      usedCount: json['usedCount'],
      hot: json['hot'],
      createTime: json['createTime'],
      name: json['name'],
      id: json['id'],
    );
  }
}
