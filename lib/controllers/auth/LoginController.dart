import 'dart:convert';
import 'dart:io';
import 'package:first_project/services/base_client.dart';
import 'package:first_project/services/app_exceptions.dart';
import 'package:first_project/helper/dialog_helper.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:first_project/views/auth/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:first_project/model/UserModel.dart';
import 'package:first_project/views/dashboard/DashboardView.dart';
import 'package:first_project/controllers/base_controller.dart';

class LoginController extends GetxController with BaseController {
  //GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var email = '';
  var password = '';
  var loginDesignation = '';
  var loginPicture = '';

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void checkLogin({@required formkey}) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formkey.currentState!.save();
    showLoading('Please wait ...');
    Map body = {
      'email': emailController.text.trim(),
      'password': passwordController.text
    };

    var response = await BaseClient()
        .post(BaseAPI.baseURL, EndPoints.login, body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = jsonDecode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    final json = jsonDecode(response);
    if (json["status"] == 200) {
      UserModal loginUser = UserModal.fromJson(json);
      final SharedPreferences? prefs = await _prefs;
      await prefs?.setString('token', loginUser.token.toString());
      await prefs?.setString('userName', loginUser.userName.toString());
      await prefs?.setString(
          'userDesignation', loginUser.userDesignation.toString());
      await prefs?.setString('email', loginUser.email.toString());
      await prefs?.setString('pictureUrl', loginUser.pictureUrl.toString());
      await prefs?.setStringList('permissions', loginUser.permissions ?? []);
      emailController.clear();
      passwordController.clear();
      Get.off(() => DashBoardScreen());
    } else {
      Get.back();
    }
  }

  //Old Function Not used
  Future<void> loginWithEmail({@required formkey}) async {
    showLoading('Please wait ...');
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formkey.currentState!.save();

    var headers = {'content-Type': 'application/json'};
    try {
      var url = Uri.parse(BaseAPI.baseURL + EndPoints.login);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);

      if (json['status'] == 200) {
        List<String> permissions = [];
        UserModal loginUser = UserModal.fromJson(json);
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', loginUser.token.toString());
        await prefs?.setString('userName', loginUser.userName.toString());
        await prefs?.setString(
            'userDesignation', loginUser.userDesignation.toString());
        await prefs?.setString('email', loginUser.email.toString());
        await prefs?.setString('pictureUrl', loginUser.pictureUrl.toString());
        await prefs?.setStringList(
            'permissions', loginUser.permissions ?? permissions);

        emailController.clear();
        passwordController.clear();

        Get.to(() => DashBoardScreen());
        //Get.off(HomeScreen());
      } else {
        Get.to(() => LoginScreen());
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  static Future<bool> isLogin() async {
    var any = await SharedPreferences.getInstance();
    if (any.getString('token') == null) {
      return false;
    } else {
      return true;
    }
  }

  static logout({String? email, String? authToken}) async {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Please wait...'),
            ],
          ),
        ),
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'content-Type': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString('token').toString(),
    };
    var body = json.encode({"email": email});
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.logout);
    http.Response response =
        await http.post(url, headers: requestHeaders, body: body);

    if (response.statusCode == 200) {
      prefs.clear();
      Get.off(() => LoginScreen());
      SystemNavigator.pop();
    } else {
      prefs.clear();
      Get.off(() => LoginScreen());
    }
  }
}
