import 'dart:io';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/model/project/ProjectListModel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:first_project/utils/FileName.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<ProjectListModal> projects = [];
  List<ProjectListModal> filterProjects = [];
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Future<List<ProjectListModal>> ProjectList({String? query}) async {
    String fileName = FileName.projectList;
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if (projects.isNotEmpty) {
      if (query != null) {
        filterProjects = projects
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterProjects;
      }
      return projects;
    }
    print("Reading Project List from API");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectList);
    http.Response response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      Iterable responseData = jsonDecode(response.body);
      projects = List<ProjectListModal>.from(
          responseData.map((model) => ProjectListModal.fromJson(model)));
      if (query != null) {
        projects = projects
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return projects;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
