import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/controllers/dashboard/DashboardController.dart';
import 'package:first_project/views/auth/LoginScreen.dart';
import 'package:first_project/views/drawer/Drawer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth/UserPreferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  UserPreference userPreference = UserPreference();
  @override
  void initState() {
    super.initState();
    //userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  Widget build(BuildContext context) {
    var user = DashboardController.getUser();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dashboard'),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         LoginController.logout();
          //         Get.to(LoginScreen());
          //       },
          //       icon: Icon(Icons.logout))
          // ],
        ),
        drawer: HomeDrawer(),
        body: Column(
          children: [],
        ));
  }
}
