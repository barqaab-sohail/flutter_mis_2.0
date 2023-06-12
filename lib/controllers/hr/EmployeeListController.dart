import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/model/hr/EmployeeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/hr/employee_documents_view.dart';

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

  Widget getEmployeeListWidget({String? query = null}) {
    return FutureBuilder<List<EmployeeModal>>(
      future: EmployeeList(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                onTap: () {
                  Get.to(EmployeeDocuments(), arguments: [
                    snapshot.data![index].id!,
                    snapshot.data![index].fullName!,
                  ]);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(snapshot.data![index].picture!,
                      fit: BoxFit.cover),
                ),
                title: Text(snapshot.data![index].fullName!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data![index].designation!),
                    Text('Employee No: ' + snapshot.data![index].employeeNo!),
                    Text(
                        'Date of Birth: ' + snapshot.data![index].dateOfBirth!),
                    Text('Age: ' + snapshot.data![index].age!),
                    Text('Date of Joining: ' +
                        snapshot.data![index].dateOfJoining!),
                    Text('Mobile: ' + snapshot.data![index].mobile!),
                    Text('Blood Group: ' + snapshot.data![index].bloodGroup!),
                    Text('Current Status: ' + snapshot.data![index].status!),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    );
  }

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

      return _employees;
    }

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
