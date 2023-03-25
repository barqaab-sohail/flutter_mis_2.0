import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:first_project/views/project/ProjectListView.dart';
import 'package:flutter/material.dart';
import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/views/auth/LoginView.dart';
import 'package:get/get.dart';
import 'package:first_project/views/hr/EmployeeListView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import '../asset/AssetListView.dart';
import '../dashboard/DashboardView.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String userName = '';
  String userDesignation = '';
  String pictureUrl = '';
  String email = '';
  String token = '';

  final employeListController = Get.put(EmployeListController());

  UserPreference userPreference = UserPreference();
  bool isAllowAssets = true;
  bool isAllowHr = true;
  bool isAllowProjects = true;

  loadUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> permissions = sp.getStringList('permissions')!;
    // isAllowAssets = permissions.contains('mis assets');
    // isAllowHr = permissions.contains('mis hr');
    // isAllowProjects = permissions.contains('mis projects');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('userName')!;
      userDesignation = prefs.getString('userDesignation')!;
      pictureUrl = prefs.getString('pictureUrl')!;
      email = prefs.getString('email')!;
      token = prefs.getString('token')!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(pictureUrl),
                  backgroundColor: Colors.transparent,
                ),
                Text(userName),
                Text(userDesignation),
                Text(email),
              ],
            ),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              Get.to(() => DashBoardScreen());
            },
          ),
          isAllowHr
              ? ListTile(
                  title: const Text('HR'),
                  onTap: () {
                    employeListController.EmployeeList();
                    Get.to(() => EmployeeList());
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    //Navigator.pop(context);
                  },
                )
              : ListTile(),
          isAllowProjects
              ? ListTile(
                  title: const Text('Projects'),
                  onTap: () {
                    Get.to(() => ProjectList());
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    //Navigator.pop(context);
                  },
                )
              : ListTile(),
          isAllowAssets
              ? ListTile(
                  title: const Text('Assets'),
                  onTap: () {
                    Get.to(() => AssetList());
                  },
                )
              : ListTile(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              child: Row(
                children: [
                  Icon(Icons.logout),
                  Text('Logout'),
                ],
              ),
              onTap: () {
                LoginController.logout(email: email, authToken: token);
              },
            ),
          )
        ],
      ),
    );
  }
}
