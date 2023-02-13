import 'dart:convert';

import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:first_project/modal/UserModal.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var email = '';
  var password = '';

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

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }

  Future<void> loginWithEmail() async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();

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
        UserModal loginUser = UserModal.fromJson(json);
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', loginUser.token.toString());
        await prefs?.setString('userName', loginUser.userName.toString());
        await prefs?.setString(
            'userDesignation', loginUser.userDesignation.toString());
        await prefs?.setString('email', loginUser.email.toString());
        await prefs?.setString('pictureUrl', loginUser.pictureUrl.toString());

        emailController.clear();
        passwordController.clear();

        //Get.off(HomeScreen());
      } else {
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
}
