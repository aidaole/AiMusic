import 'al.dart';
import 'ar.dart';

class Song {
  String? name;
  int? id;
  List<Ar>? ar;
  Al? al;

  Song({
    this.name,
    this.id,
    this.ar,
    this.al,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        name: json['name'] as String?,
        id: json['id'] as int?,
        ar: (json['ar'] as List<dynamic>?)
            ?.map((e) => Ar.fromJson(e as Map<String, dynamic>))
            .toList(),
        al: json['al'] == null
            ? null
            : Al.fromJson(json['al'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'ar': ar?.map((e) => e.toJson()).toList(),
        'al': al?.toJson(),
      };
}
