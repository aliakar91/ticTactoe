class AppConstants {
  static const String baseUrl = "http://212.71.244.117/api";

  // milliseconds
  static const int delayForSplashScreen = 700;
}

class BoxStorageKeys {
  static const String appUser = "app_user";
  static const String loggedIn = "logged_in";
}

class RequestHeaderKeys {
  static const String authorization = "Authorization";
}

class ApiUrls {
  static const String baseUrl = "${AppConstants.baseUrl}/api";
  static const String addBallotBox = "$baseUrl/send-result";
  static const String addImage = "$baseUrl/send-report-image";
  static const String refreshAccessToken = "${baseUrl}auth/refresh_access/";
  static const String userLogin = "$baseUrl/user-login";
  static const String getBoxes = "$baseUrl/user-ballot-boxes";
  static String getBox(id) => "$baseUrl/ballot-box/$id";
}