class AppUserToken {
  String accessToken;
  String tokenScheme;

  AppUserToken({
    required this.accessToken,
    required this.tokenScheme,
  });

  factory AppUserToken.fromJson(Map<String, dynamic> json) => AppUserToken(
        accessToken: json["access_token"],
        tokenScheme: json["token_scheme"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_scheme": tokenScheme,
      };

  String getAccessTokenWithScheme() {
    return "$tokenScheme $accessToken";
  }
}
