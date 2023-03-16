import 'dart:async';
import 'package:first_project/model/project/ProjectListModal.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectListController extends GetxController {
  List<ProjectListModal> _projects = [];
  List<ProjectListModal> fitlerProjects = [];
  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ProjectListModal>> ProjectList({String? query}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';
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
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectList);
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
