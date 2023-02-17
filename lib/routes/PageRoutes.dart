import 'package:first_project/main.dart';
import 'package:first_project/views/asset/AssetList.dart';
import 'package:get/get.dart';
import 'package:first_project/binding/Binding.dart';
import 'package:first_project/views/dashboard/Dashboard.dart';
import 'package:first_project/views/auth/LoginScreen.dart';
import 'package:first_project/views/hr/EmployeeList.dart';
import 'package:first_project/views/project/ProjectList.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LoginScreen(),
    ),
    GetPage(
        name: Routes.DASHBAORD,
        page: () => DashBoardScreen(),
        binding: InitialBinding()),
    GetPage(
        name: Routes.HR, page: () => EmployeeList(), binding: InitialBinding()),
    GetPage(
        name: Routes.PROJECTS,
        page: () => ProjectList(),
        binding: InitialBinding()),
    GetPage(
        name: Routes.ASSETS, page: () => AssetList(), binding: InitialBinding())
  ];
}

class Routes {
  static const String LOGIN_SCREEN = "/";
  static const String DASHBAORD = "/dashboard";
  static const String HR = "/employee_list";
  static const String ASSETS = "/asset_list";
  static const String PROJECTS = "/project_list";
}
