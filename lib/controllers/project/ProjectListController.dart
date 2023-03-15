import 'dart:io';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/modal/project/ProjectListModal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:first_project/utils/FileName.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<ProjectListModal> _projects = [];
  List<ProjectListModal> filterProjects = [];
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Future<List<ProjectListModal>> ProjectList({String? query}) async {
    if (_projects.isNotEmpty) {
      if (query != null) {
        filterProjects = _projects
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterProjects;
      }
      print('From save value');
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
