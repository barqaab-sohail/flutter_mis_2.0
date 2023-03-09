import 'package:first_project/modal/hr/EmployeeModal.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/controllers/auth/UserPreferences.dart';

class FetchEmployeeList {
  var token = '';
  UserPreference userPreference = UserPreference();
  @override
  FetchEmployeeList() {
    userPreference.getUser().then((value) => {token = value.token!});
  }

  var data = [];
  List<EmployeeModal> results = [];
  String urlList = BaseAPI.baseURL + EndPoints.employeeList;

  Future<List<EmployeeModal>> getEmployeeList({String? query}) async {
    results = data.map((e) => EmployeeModal.fromJson(e)).toList();
    if (query != null) {
      results = results
          .where((element) =>
              element.fullName!.toLowerCase().contains((query.toLowerCase())))
          .toList();
    }
    return results;
  }
}
