import 'song.dart';

class WeekDatum {
  int? playCount;
  int? score;
  Song? song;

  WeekDatum({this.playCount, this.score, this.song});

  factory WeekDatum.fromJson(Map<String, dynamic> json) => WeekDatum(
        playCount: json['playCount'] as int?,
        score: json['score'] as int?,
        song: json['song'] == null
            ? null
            : Song.fromJson(json['song'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'playCount': playCount,
        'score': score,
        'song': song?.toJson(),
      };
}
