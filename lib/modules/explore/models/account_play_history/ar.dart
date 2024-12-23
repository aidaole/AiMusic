class Ar {
  int? id;
  String? name;
  List<dynamic>? tns;
  List<dynamic>? alias;

  Ar({this.id, this.name, this.tns, this.alias});

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
        id: json['id'] as int?,
        name: json['name'] as String?,
        tns: json['tns'] as List<dynamic>?,
        alias: json['alias'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tns': tns,
        'alias': alias,
      };
}
