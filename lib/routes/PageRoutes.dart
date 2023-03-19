import 'package:first_project/main.dart';
import 'package:first_project/views/asset/AssetListView.dart';
import 'package:get/get.dart';
import 'package:first_project/binding/Binding.dart';
import 'package:first_project/views/dashboard/DashboardView.dart';
import 'package:first_project/views/auth/LoginView.dart';
import 'package:first_project/views/hr/EmployeeListView.dart';
import 'package:first_project/views/project/ProjectListView.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN_SCREEN,
        page: () => LoginScreen(),
        binding: InitialBinding()),
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
        name: Routes.ASSETS,
        page: () => AssetList(),
        binding: InitialBinding()),
  ];
}

class Routes {
  static const String LOGIN_SCREEN = "/";
  static const String DASHBAORD = "/dashboard";
  static const String HR = "/employee_list";
  static const String ASSETS = "/asset_list";
  static const String PROJECTS = "/project_list";
}
