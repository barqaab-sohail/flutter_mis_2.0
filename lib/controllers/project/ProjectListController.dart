import 'dart:async';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/model/project/ProjectListModal.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListController extends GetxController {
  UserPreference userPreference = UserPreference();
  List<ProjectListModal> _projects = [];
  List<ProjectListModal> fitlerProjects = [];
  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ProjectListModal>> ProjectList(
      {required String authToken, String? query}) async {
    if (_projects.isNotEmpty) {
      if (query != null) {
        fitlerProjects = _projects
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return fitlerProjects;
      }
      return _projects;
    }
    print("Reading Project List from API");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + authToken
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectList);
    print(requestHeaders);
    http.Response response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      _projects = List<ProjectListModal>.from(
              responseData.map((model) => ProjectListModal.fromJson(model)))
          .toList();

      return _projects;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
