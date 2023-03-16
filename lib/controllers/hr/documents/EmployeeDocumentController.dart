import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:first_project/model/hr/EmployeeDocumentModel.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeDocumentController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<EmployeeDocumentModel> _employeeDocuments = [];
  List<EmployeeDocumentModel> filterDocuments = [];
  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}

  Future<List<EmployeeDocumentModel>> getEmployeeDocuments(
      {required String id, String? query}) async {
    if (_employeeDocuments.isNotEmpty) {
      if (query != null) {
        filterDocuments = _employeeDocuments
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterDocuments;
      }
      print('From save value');
      return _employeeDocuments;
    }
    print('fetching from API');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeDocuments + id);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      _employeeDocuments = List<EmployeeDocumentModel>.from(responseData
          .map((model) => EmployeeDocumentModel.fromJson(model))).toList();
      return _employeeDocuments;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
