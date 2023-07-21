import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:party_proje_deneme/app/commons/toast_message.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/data/models/app_user_token.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/data/models/network_response.dart';
import 'package:party_proje_deneme/app/modules/login_module/login_view.dart';

class NetworkService {
  late bool showError;
  final Duration timeOut = const Duration(seconds: 30);
  final box = GetStorage();

  NetworkService();

  Future<dynamic> request({
    required RequestType requestType,
    required String url,
    Map<String, String>? headers,
    Object? data,
    bool error = true,
    bool callRecursively = true,
    List<http.MultipartFile>? multipartFileList,
    Map<String, String>? queryParameters,
  }) async {
    http.Response res;
    AppUserToken? appUserToken;
    // for error feedback, default true
    showError = error;

    if (queryParameters != null) {
      url += "?${Uri(queryParameters: queryParameters).query}";
    }

    Uri uri = Uri.parse(url);
    var appUserTokenJson = await box.read(BoxStorageKeys.appUserToken);
    headers = <String, String>{"Content-Type": "application/json"};

    if (appUserTokenJson != null &&
        !headers.containsKey(RequestHeaderKeys.authorization)) {
      appUserToken = AppUserToken.fromJson(appUserTokenJson);
      headers.addAll({
        RequestHeaderKeys.authorization: appUserToken.getAccessTokenWithScheme()
      });
    }

    try {
      if (requestType == RequestType.post) {
        res = await http
            .post(uri, body: jsonEncode(data), headers: headers)
            .timeout(timeOut);
      } else if (requestType == RequestType.put) {
        res = await http
            .put(uri, body: jsonEncode(data), headers: headers)
            .timeout(timeOut);
      } else if (requestType == RequestType.delete) {
        res = await http
            .delete(uri, body: jsonEncode(data), headers: headers)
            .timeout(timeOut);
      } else if (requestType == RequestType.multiPartPost) {
        http.MultipartRequest multipartRequest = await multipartPostRequest(
            headers, uri, data, multipartFileList, "POST");

        res = await http.Response.fromStream(await multipartRequest.send());
      } else if (requestType == RequestType.multiPartPut) {
        http.MultipartRequest multipartRequest = await multipartPostRequest(
            headers, uri, data, multipartFileList, "PUT");

        res = await http.Response.fromStream(await multipartRequest.send());
      } else {
        res = await http.get(uri, headers: headers).timeout(timeOut);
      }

      if (res.statusCode == HttpStatus.forbidden &&
          appUserToken != null &&
          callRecursively) {
        bool result = false; //await refreshAccessToken(appUserToken);
        if (result) {
          headers.remove(RequestHeaderKeys.authorization);

          return await request(
              requestType: requestType, url: url, headers: headers);
        } else {
          signOut();
        }
      } else {
        print(res.statusCode);
        print("Decode ${jsonDecode(utf8.decode(res.bodyBytes))}");
        return NetworkResponse(
          statusCode: res.statusCode,
          body: res.statusCode != HttpStatus.internalServerError
              ? jsonDecode(utf8.decode(res.bodyBytes))
              : "",
        );
      }
    } on SocketException {
      LoginShowToastMessage.showToastMessage("Bağlantı Hatası");
    } on TimeoutException {
      LoginShowToastMessage.showToastMessage(
        "Zaman Aşımı",
      );
    }

    return null;
  }

  Future<http.MultipartRequest> multipartPostRequest(
    Map<String, String> headers,
    Uri uri,
    Object? data,
    List<http.MultipartFile>? multipartFileList,
    String method,
  ) async {
    http.MultipartRequest multipartRequest = http.MultipartRequest(method, uri);
    multipartRequest.headers.addAll(headers);

    if (data != null) {
      multipartRequest.fields.addAll(data as Map<String, String>);
    }

    if (multipartFileList != null) {
      multipartRequest.files.addAll(multipartFileList);
    }

    return multipartRequest;
  }

  // Future<bool> refreshAccessToken(
  //     AppUserToken appUserToken,
  //     ) async {
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "application/json",
  //     RequestHeaderKeys.authorization: appUserToken.getRefreshTokenWithScheme(),
  //   };
  //
  //   // get access token with refresh token
  //   var result = await request(
  //     requestType: RequestType.get,
  //     url: ApiUrls.refreshAccessToken,
  //     headers: headers,
  //     callRecursively: false,
  //   );
  //
  //   if (result.statusCode == HttpStatus.ok) {
  //     appUserToken.accessToken = result.body['access_token'];
  //     await box.write(BoxStorageKeys.appUserToken, appUserToken.toJson());
  //
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> signOut() async {
    await box.erase();
    Get.offAll(() => LoginView());
  }
}
