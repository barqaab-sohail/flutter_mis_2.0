import 'dart:io';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/modal/hr/EmployeeModal.dart';
import '../../utils/FileName.dart';

class EmployeListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';

  @override
  void onInit() {
    super.onInit();
    //EmployeeList().then((value) => foundEmployees.value = value);

    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}

  Future<List<EmployeeModal>> EmployeeList({String? query}) async {
    //var headers = {'content-Type': 'application/json'};

    String fileName = FileName.employeeList;
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("Reading File from Device Cache");
      final data = file.readAsStringSync();
      Iterable responseData = jsonDecode(data);
      List<EmployeeModal> employees = List<EmployeeModal>.from(
          responseData.map((model) => EmployeeModal.fromJson(model))).toList();

      if (query != null) {
        employees = employees
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return employees;
    } else {
      print('fetching from API');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + token
      };
      var url = Uri.parse(BaseAPI.baseURL + EndPoints.employeeList);
      http.Response response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        Iterable responseData = jsonDecode(response.body);
        List<EmployeeModal> employees = List<EmployeeModal>.from(
                responseData.map((model) => EmployeeModal.fromJson(model)))
            .toList();

        if (query != null) {
          employees = employees
              .where((element) => element
                  .toJson()
                  .toString()
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
        return employees;
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    }
  }
}
