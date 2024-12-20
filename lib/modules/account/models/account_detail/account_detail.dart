import 'profile.dart';

class AccountDetail {
  int? level;
  Profile? profile;
  int? code;

  AccountDetail({
    this.level,
    this.profile,
    this.code,
  });

  @override
  @override
  String toString() {
    return 'AccountDetail(level: $level, profile: $profile, code: $code)';
  }

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        level: json['level'] as int?,
        profile: json['profile'] == null
            ? null
            : Profile.fromJson(json['profile'] as Map<String, dynamic>),
        code: json['code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'level': level,
        'profile': profile?.toJson(),
        'code': code,
      };
}
