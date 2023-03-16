import 'package:first_project/controllers/asset/AssetListController.dart';
import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/controllers/dashboard/DashboardController.dart';
import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:first_project/controllers/project/ProjectListController.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // here we init our controllers or initial things
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => EmployeListController());
    Get.lazyPut(() => ProjectListController());
    Get.lazyPut(() => AssetListController());
  }
}
