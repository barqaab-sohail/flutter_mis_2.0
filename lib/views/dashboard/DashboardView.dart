import 'package:first_project/controllers/dashboard/DashboardController.dart';
import 'package:first_project/views/drawer/DrawerView.dart';
import 'package:flutter/material.dart';
import '../../controllers/auth/UserPreferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  UserPreference userPreference = UserPreference();
  var token = '';
  @override
  void initState() {
    super.initState();
    userPreference.getUser().then((value) => {token = value.token!});
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