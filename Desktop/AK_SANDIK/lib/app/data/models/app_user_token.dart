import 'package:ak_sandik/app/data/models/app_user.dart';

class AppUserToken {
  String accessToken;
  String tokenScheme;
  String refreshToken;
  AppUser user;

  AppUserToken({
    required this.accessToken,
    required this.tokenScheme,
    required this.refreshToken,
    required this.user,
  });

  factory AppUserToken.fromJson(Map<String, dynamic> json) => AppUserToken(
        accessToken: json["access_token"],
        tokenScheme: json["token_scheme"],
        refreshToken: json["refresh_token"],
        user: AppUser.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_scheme": tokenScheme,
        "refresh_token": refreshToken,
        "user": user.toJson(),
      };

  String getAccessTokenWithScheme() {
    return "$tokenScheme $accessToken";
  }

  String getRefreshTokenWithScheme() {
    return "$tokenScheme $refreshToken";
  }
}
