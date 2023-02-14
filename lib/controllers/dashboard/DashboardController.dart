import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var userName = '';
  var email = '';
  var picture = '';
  var userDesignation = '';

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = await prefs.getString('userName').toString();
    return userName;
  }
}
