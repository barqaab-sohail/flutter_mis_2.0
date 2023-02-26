import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/modal/hr/EmployeeModal.dart';

class EmployeListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  Rx<List<EmployeeModal>> foundEmployees = Rx<List<EmployeeModal>>([]);

  @override
  void onInit() {
    super.onInit();
    EmployeeList().then((value) => foundEmployees.value = value);
    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}
  void filterEmployee(String searchText) async {
    List<EmployeeModal> results = ([]);
    ;
    if (searchText == null) {
      results = await EmployeeList();
    } else {
      results = foundEmployees.map((data) => data?.where((element) =>  element.toString()
              .toLowerCase().contains(searchText.toLowerCase())));

  }

  Future<List<EmployeeModal>> EmployeeList() async {
    //var headers = {'content-Type': 'application/json'};
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeList);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      List<EmployeeModal> employees = List<EmployeeModal>.from(
          responseData.map((model) => EmployeeModal.fromJson(model)));
      return employees;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
