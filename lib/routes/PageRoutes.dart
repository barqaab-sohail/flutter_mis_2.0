import 'package:first_project/main.dart';
import 'package:get/get.dart';
import 'package:first_project/binding/Binding.dart';
import 'package:first_project/views/dashboard/Dashboard.dart';
import 'package:first_project/views/auth/LoginScreen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LoginScreen(),
    ),
    GetPage(
        name: Routes.DASHBAORD,
        page: () => DashBoardScreen(),
        binding: InitialBinding())
  ];
}

class Routes {
  static const String LOGIN_SCREEN = "/";
  static const String DASHBAORD = "/dashboard";
  static const String HR = "/hr";
  static const String ASSETS = "/assets";
}
