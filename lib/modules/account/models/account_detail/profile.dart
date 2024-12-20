class Profile {
  int? vipType;
  String? nickname;
  int? backgroundImgId;
  String? backgroundUrl;
  String? avatarUrl;
  String? description;
  bool? followed;
  int? userId;
  String? signature;
  int? followeds;
  int? follows;

  Profile({
    this.vipType,
    this.nickname,
    this.avatarUrl,
    this.description,
    this.followed,
    this.userId,
    this.signature,
    this.followeds,
    this.follows,
  });

  @override
  String toString() {
    return 'Profile(vipType: $vipType, nickname: $nickname, avatarUrl: $avatarUrl, description: $description, followed: $followed, userId: $userId, signature: $signature, followeds: $followeds, follows: $follows)';
  }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        vipType: json['vipType'] as int?,
        nickname: json['nickname'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        description: json['description'] as String?,
        followed: json['followed'] as bool?,
        userId: json['userId'] as int?,
        signature: json['signature'] as String?,
        followeds: json['followeds'] as int?,
        follows: json['follows'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'vipType': vipType,
        'nickname': nickname,
        'avatarUrl': avatarUrl,
        'description': description,
        'followed': followed,
        'userId': userId,
        'signature': signature,
        'followeds': followeds,
        'follows': follows,
      };
}
