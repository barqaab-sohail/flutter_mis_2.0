import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var userName = Get.arguments![0] ?? '';
  var userDesignation = Get.arguments![1] ?? '';
  var email = Get.arguments![2] ?? '';
  var pictureUrl = Get.arguments![3] ?? '';

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = await prefs.getString('userName').toString();
    return userName;
  }
}
