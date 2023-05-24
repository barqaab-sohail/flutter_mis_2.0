import 'dart:async';
import 'package:first_project/model/project/BudgetChartModel.dart';
import 'package:first_project/model/project/ProjectListModel.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/project/ProjectLedgerActivityModel.dart';

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

  Future<BudgetChartModel> getProejctChart({required String id}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var url = Uri.parse(BaseAPI.baseURL + EndPoints.proejctSummaryMM + id);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      BudgetChartModel data = BudgetChartModel.fromJson(responseData);
      return data;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }

  Future<ProjectLedgerActivityModel> getProjectLedgerActivty(
      {required String id}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectLedgerActivity + id);
    http.Response response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      ProjectLedgerActivityModel data =
          ProjectLedgerActivityModel.fromJson(responseData);
      return data;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
