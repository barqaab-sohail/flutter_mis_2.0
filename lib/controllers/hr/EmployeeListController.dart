import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/modal/hr/EmployeeModal.dart';

class EmployeListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Future<void> EmployeeList() async {
    var headers = {'content-Type': 'application/json'};
    try {
      var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeList);
      Map body = {
        'token': 'Bearer ' + token,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (json['status'] == 200) {
        print('Request is found OK');
        //Get.to(() => EmployeeList());
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
