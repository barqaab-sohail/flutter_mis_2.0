import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modal/UserModal.dart';

class UserPreference {
  Future<bool> saveUser(UserModal responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token.toString());
    sp.setString('userName', responseModel.userName.toString());
    sp.setString('userDesignation', responseModel.userDesignation.toString());
    sp.setString('email', responseModel.email.toString());
    sp.setString('pictureUrl', responseModel.pictureUrl.toString());
    // sp.setBool('isLogin', responseModel.isLogin!);

    return true;
  }

  Future<UserModal> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    String? userName = sp.getString('userName');
    String? userDesignation = sp.getString('userDesignation');
    String? email = sp.getString('email');
    String? pictureUrl = sp.getString('pictureUrl');

    // bool? isLogin = sp.getBool('isLogin');

    return UserModal(
        token: token,
        userName: userName,
        userDesignation: userDesignation,
        email: email,
        pictureUrl: pictureUrl);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
