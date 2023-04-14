import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/project/ProjectDocumentModel.dart';

class ProjectDocumentController extends GetxController {
  UserPreference userPreference = UserPreference();
  List<ProjectDocumentModel> allProjectDocuments = [];
  List<ProjectDocumentModel> filterAllProjectDocuments = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  Future<List<ProjectDocumentModel>> getProjectDocuments(
      {required String id, String? query}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var url = Uri.parse(BaseAPI.baseURL + EndPoints.projectDocuments + id);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      List<ProjectDocumentModel> projectDocuments =
          List<ProjectDocumentModel>.from(responseData
              .map((model) => ProjectDocumentModel.fromJson(model))).toList();
      if (query != null) {
        projectDocuments = projectDocuments
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return projectDocuments;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }

  Future<List<ProjectDocumentModel>> getAllProjectDocuments(
      {String? query}) async {
    if (allProjectDocuments.isNotEmpty) {
      if (query != null) {
        filterAllProjectDocuments = allProjectDocuments
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterAllProjectDocuments;
      }
      return allProjectDocuments;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var url = Uri.parse(BaseAPI.baseURL + EndPoints.allProjectDocuments);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      allProjectDocuments = List<ProjectDocumentModel>.from(
              responseData.map((model) => ProjectDocumentModel.fromJson(model)))
          .toList();

      if (query != null) {
        allProjectDocuments = allProjectDocuments
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return allProjectDocuments;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
