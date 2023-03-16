import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/model/hr/EmployeeDocumentModel.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDocumentController extends GetxController {
  UserPreference userPreference = UserPreference();

  List<EmployeeDocumentModel> filterDocuments = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  Future<List<EmployeeDocumentModel>> getEmployeeDocuments(
      {required String id, String? query}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeDocuments + id);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      List<EmployeeDocumentModel> employeeDocuments =
          List<EmployeeDocumentModel>.from(responseData
              .map((model) => EmployeeDocumentModel.fromJson(model))).toList();
      if (query != null) {
        employeeDocuments = employeeDocuments
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return employeeDocuments;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
