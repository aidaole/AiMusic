class AccountModel {
  final int userId;
  final int vipType;
  final String signature;
  final String nickname;
  final String avatarUrl;
  final String backgroundUrl;
  int follows;
  int fans;

  AccountModel({
    this.userId = 0,
    this.vipType = 0,
    this.nickname = "Nickname",
    this.avatarUrl = "",
    this.signature = "",
    this.backgroundUrl = "",
    this.follows = 0,
    this.fans = 0,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    final profile = json['data']['profile'];
    final account = json['data']['account'];
    return AccountModel(
      userId: account['id'] ?? 0,
      vipType: account['vipType'] ?? 0,
      nickname: profile['nickname'] ?? "Nickname",
      avatarUrl: profile['avatarUrl'] ?? "",
      signature: profile['signature'] ?? "",
      backgroundUrl: profile['backgroundUrl'] ?? "",
      follows: profile['follows'] ?? 0,
      fans: profile['fans'] ?? 0,
    );
  }
}
