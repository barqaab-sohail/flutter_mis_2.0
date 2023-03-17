import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/model/hr/EmployeeModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeListController extends GetxController {
  UserPreference userPreference = UserPreference();

  List<EmployeeModal> _employees = [];
  List<EmployeeModal> filterEmployees = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  Future<List<EmployeeModal>> EmployeeList({String? query}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';
    if (_employees.isNotEmpty) {
      if (query != null) {
        filterEmployees = _employees
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterEmployees;
      }
      print('From save value');
      return _employees;
    }
    print('fetching from API');
    await Future.delayed(const Duration(seconds: 2));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeList);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      _employees = List<EmployeeModal>.from(
          responseData.map((model) => EmployeeModal.fromJson(model))).toList();

      return _employees;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
