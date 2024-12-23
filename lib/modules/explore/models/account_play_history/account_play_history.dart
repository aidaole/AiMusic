import 'week_datum.dart';

class AccountPlayHistory {
  List<WeekDatum>? weekData;
  int? code;

  AccountPlayHistory({this.weekData, this.code});

  factory AccountPlayHistory.fromJson(Map<String, dynamic> json) {
    return AccountPlayHistory(
      weekData: (json['weekData'] as List<dynamic>?)
          ?.map((e) => WeekDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'weekData': weekData?.map((e) => e.toJson()).toList(),
        'code': code,
      };
}
