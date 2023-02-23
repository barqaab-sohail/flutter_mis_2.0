import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/modal/project/ProjectListModal.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Future<List<ProjectListModal>> ProjectList() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeList);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      List<ProjectListModal> projects = List<ProjectListModal>.from(
          responseData.map((model) => ProjectListModal.fromJson(model)));
      return projects;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
