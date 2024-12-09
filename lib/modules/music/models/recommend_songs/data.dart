import 'song.dart';

class Data {
  List<Song>? dailySongs;

  Data({
    this.dailySongs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dailySongs: (json['dailySongs'] as List<dynamic>?)
            ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dailySongs': dailySongs?.map((e) => e.toJson()).toList(),
      };
}
