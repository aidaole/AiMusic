class Al {
  int? id;
  String? name;
  String? picUrl;
  List<dynamic>? tns;
  String? picStr;
  int? pic;

  Al({this.id, this.name, this.picUrl, this.tns, this.picStr, this.pic});

  factory Al.fromJson(Map<String, dynamic> json) => Al(
        id: json['id'] as int?,
        name: json['name'] as String?,
        picUrl: json['picUrl'] as String?,
        tns: json['tns'] as List<dynamic>?,
        picStr: json['pic_str'] as String?,
        pic: json['pic'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'picUrl': picUrl,
        'tns': tns,
        'pic_str': picStr,
        'pic': pic,
      };
}
