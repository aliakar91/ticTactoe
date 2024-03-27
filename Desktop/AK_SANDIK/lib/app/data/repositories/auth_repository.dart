import 'package:get_storage/get_storage.dart';
import 'package:ak_sandik/app/data/models/app_user_token.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:ak_sandik/app/data/providers/auth_provider.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class AuthRepository {
  final authProvider = AuthProvider();
  final box = GetStorage();

  Future<dynamic> login(String phoneNumber, String password) async {
    var data = {"phone_number": phoneNumber, "password": password};
    var response = await authProvider.login(data);

    if (response.statusCode == HttpStatus.ok) {
      AppUserToken appUser = AppUserToken.fromJson(response.body);
      await box.write(BoxStorageKeys.appUser, appUser.toJson());
      await box.write(BoxStorageKeys.loggedIn, true);
      return true;
    } else {
      return false;
    }
  }
}
