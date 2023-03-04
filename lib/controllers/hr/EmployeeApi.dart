import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:first_project/modal/hr/EmployeeModal.dart';
import 'package:first_project/controllers/auth/UserPreferences.dart';

class FetchEmployeeList {
  UserPreference userPreference = UserPreference();
  var token = '';

  FetchEmployeeList() {
    userPreference.getUser().then((value) => {token = value.token!});
  }

  Iterable data = [];
  List<EmployeeModal> results = [];
  String urlList = BaseAPI.baseURL + EndPoints.employeeList;

  Future<List<EmployeeModal>> getEmployeeList({String? query}) async {
    Map<String, String> requestHeaders = {'Authorization': 'Bearer ' + token};
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        results = List<EmployeeModal>.from(
            data.map((model) => EmployeeModal.fromJson(model)));

        if (query != null) {
          results = results
              .where((element) => element.fullName
                  .toString()
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
