import 'package:first_project/controllers/hr/EmployeeListController.dart';
import 'package:first_project/views/project/ProjectListView.dart';
import 'package:first_project/views/project_documents/AllProjectDocumentsView.dart';
import 'package:flutter/material.dart';
import 'package:first_project/controllers/auth/LoginController.dart';
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
  bool isAllowAssets = false;
  bool isAllowHr = false;
  bool isAllowProjects = false;
  bool isAllowProjectDocuments = false;

  loadUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> permissions = sp.getStringList('permissions')!;
    isAllowHr = permissions.contains('mis hr');
    isAllowProjects = permissions.contains('mis projects');
    isAllowProjectDocuments = permissions.contains('mis all projects');
    isAllowAssets = permissions.contains('mis assets');

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
          ListTile(
            title: const Text('HR'),
            onTap: () {
              employeListController.EmployeeList();
              isAllowHr ? Get.to(() => EmployeeList()) : unAuthorized();
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Projects'),
            onTap: () {
              isAllowProjects ? Get.to(() => ProjectList()) : unAuthorized();
              ;
            },
          ),
          ListTile(
            title: const Text('Project Documents'),
            onTap: () {
              isAllowProjectDocuments
                  ? Get.to(() => AllProjectDocumentsView())
                  : unAuthorized();
              ;
            },
          ),
          ListTile(
            title: const Text('Assets'),
            onTap: () {
              isAllowAssets ? Get.to(() => AssetList()) : unAuthorized();
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Get.defaultDialog(
                title: "Confirmation",
                content: getContent(),
                barrierDismissible: false,
                radius: 50.0,
                confirm: confirmBtn(email, token),
                cancel: cancelBtn(),
              );
              //LoginController.logout(email: email, authToken: token);
            },
          ),
        ],
      ),
    );
  }
}

Widget getContent() {
  return Column(
    children: [
      Text("Are you sure to logout"),
    ],
  );
}

Widget confirmBtn(String email, String token) {
  return ElevatedButton(
      onPressed: () {
        LoginController.logout(email: email, authToken: token);
      },
      child: Text("Confirm"));
}

Widget cancelBtn() {
  return ElevatedButton(
      onPressed: () {
        Get.back();
      },
      child: Text("Cancel"));
}

unAuthorized() {
  Get.defaultDialog(
    title: "Error",
    middleText: "You are not Authorized",
    textCancel: "Cancel",
    cancelTextColor: Colors.white,
    buttonColor: Colors.white,
    backgroundColor: Colors.red,
    titleStyle: TextStyle(color: Colors.white),
    middleTextStyle: TextStyle(color: Colors.white),
  );
}
