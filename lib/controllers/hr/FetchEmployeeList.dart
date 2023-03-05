import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:first_project/modal/hr/EmployeeModal.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:api_cache_manager/api_cache_manager.dart';

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
    var isCacheExist = await APICacheManager().getCacheData('employee_list');
    if (isCacheExist == null) {
      print('API request');
      var url = Uri.parse(urlList);
      try {
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token
        };
        var response = await http.get(url, headers: requestHeaders);
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "employee_list", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);

          data = json.decode(response.body);
          results = data.map((e) => EmployeeModal.fromJson(e)).toList();
          if (query != null) {
            results = results
                .where((element) => element.fullName!
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
    } else {
      print('cache data');
      var cacheData = await APICacheManager().getCacheData('employee_list');
      data = json.decode(cacheData.syncData);
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
}
