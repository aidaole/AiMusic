class HighQulityTags {
  List<Tag>? tags;
  int? code;

  HighQulityTags({this.tags, this.code});

  factory HighQulityTags.fromJson(Map<String, dynamic> json) {
    return HighQulityTags(
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'tags': tags?.map((e) => e.toJson()).toList(),
        'code': code,
      };
}

class Tag {
  int? category;
  String? name;
  int? id;
  int? type;

  Tag({
    this.category,
    this.name,
    this.id,
    this.type,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        category: json['category'] as int?,
        name: json['name'] as String?,
        id: json['id'] as int?,
        type: json['type'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'category': category,
        'name': name,
        'id': id,
        'type': type,
      };
}