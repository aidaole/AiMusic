class AccountModel {
  final String nickname;
  final String avatarUrl;
  final String backgroundUrl;
  final int follows;
  final int fans;
  final int gained;

  AccountModel({
    this.nickname = "Nickname",
    this.avatarUrl = "",
    this.backgroundUrl = "",
    this.follows = 0,
    this.fans = 0,
    this.gained = 0,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    final profile = json['data']['profile'];
    return AccountModel(
      nickname: profile['nickname'] ?? "Nickname",
      avatarUrl: profile['avatarUrl'] ?? "",
      backgroundUrl: profile['backgroundUrl'] ?? "",
    );
  }
} 