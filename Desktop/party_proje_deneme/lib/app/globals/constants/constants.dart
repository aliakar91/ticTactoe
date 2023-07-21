import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = "http://139.162.177.131/sandik";
}

class BoxStorageKeys {
  static const String appUser = "app_user";
  static const String appUserToken = "app_user_tokens";
  static const String loggedIn = "logged_in";
}

class RequestHeaderKeys {
  static const String authorization = "Authorization";
}

class ApiUrls {
  static const String baseUrl = "${AppConstants.baseUrl}/api";
  static const String addBallotBox = "$baseUrl/send-result";
  static const String addImage="$baseUrl/send-report-image";
}

class ListViewSize {
  static double listViewHeight(BuildContext context) =>
      MediaQuery.of(context).size.height / 1.5;
}

class StorageVoteKey {
  static const String storageVoteSaveKey = "storageVoteSaveKey";
}
