import 'package:get_storage/get_storage.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:party_proje_deneme/app/data/models/app_user.dart';
import 'package:party_proje_deneme/app/data/models/app_user_token.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/data/providers/login_provider.dart';

class LoginRepository {
  final _loginProvider = LoginProvider();
  final _box = GetStorage();

  Future<dynamic> loginInfo(String tcNo, String password) async {
    var response = await _loginProvider.loginInfo(tcNo, password);
    if (response.statusCode == HttpStatus.ok) {
      AppUserToken appUserToken = AppUserToken(
        accessToken: response.body['access_token'],
        tokenScheme: response.body['token_scheme'],
      );
      AppUser appUser = AppUser(
        id: response.body['user']['id'],
        tcNo: response.body['user']['tc_no'],
      );
      await _box.write(BoxStorageKeys.appUser, appUser.toJson());
      await _box.write(BoxStorageKeys.appUserToken, appUserToken.toJson());
      await _box.write(BoxStorageKeys.loggedIn, true);
      return true;
    } else {
      return false;
    }
  }
}
