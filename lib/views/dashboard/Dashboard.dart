import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/controllers/dashboard/DashboardController.dart';
import 'package:first_project/views/auth/LoginScreen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String name = "Sohail Afzal";
  @override
  Widget build(BuildContext context) {
    var user = DashboardController.getUser();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.backpack)),
          centerTitle: true,
          title: Text('Dashboard'),
          actions: [
            IconButton(
                onPressed: () {
                  LoginController.logout();
                  Get.to(LoginScreen());
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [Text("It is User Name ")],
        ));
  }
}
