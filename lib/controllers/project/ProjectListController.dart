import 'dart:async';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/modal/project/ProjectListModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<ProjectListModal> _projects = [];
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Future<List<ProjectListModal>> ProjectList({String? query}) async {
    if (_projects.isNotEmpty) {
      return _projects;
    }
    print("Reading Project List from API");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectList);
    http.Response response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      debugPrint(response.body.toString());
      _projects = List<ProjectListModal>.from(
          responseData.map((model) => ProjectListModal.fromJson(model)));
      if (query != null) {
        _projects = _projects
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return _projects;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
