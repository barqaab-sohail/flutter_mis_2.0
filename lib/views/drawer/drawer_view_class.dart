import 'package:first_project/model/drawer_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth/LoginController.dart';

class DrawerViewClass {
  bool isAllowAssets = false;
  bool isAllowHr = false;
  bool isAllowProjects = false;
  bool isAllowProjectDocuments = false;
  String userName = '';
  String userDesignation = '';
  String pictureUrl = '';
  String email = '';
  String token = '';

  List<Menu> data = [];

  DrawerViewClass() {
    loadUserData();
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
  }

  loadUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> permissions = sp.getStringList('permissions')!;
    isAllowHr = permissions.contains('mis hr');
    isAllowProjects = permissions.contains('mis projects');
    isAllowProjectDocuments = permissions.contains('mis all projects');
    isAllowAssets = permissions.contains('mis assets');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName')!;
    userDesignation = prefs.getString('userDesignation')!;
    pictureUrl = prefs.getString('pictureUrl')!;
    email = prefs.getString('email')!;
    token = prefs.getString('token')!;
  }

  bool checkAuth(String route) {
    if (route == "/employee_list") {
      return isAllowHr;
    }
    if (route == "/project_list") {
      return isAllowProjects;
    }
    if (route == "/all_projects_documents") {
      return isAllowProjectDocuments;
    }
    if (route == "/asset_list") {
      return isAllowAssets;
    }
    if (route == "/dashboard") {
      return true;
    }
    if (route == "/logout") {
      return true;
    }
    return false;
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

  Widget buildDrawer() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildDrawerHeader(data[index]);
        }
        return _buildMenuList(data[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        thickness: 2,
      ),
    );
  }

  Widget _buildDrawerHeader(Menu headItem) {
    return DrawerHeader(
        margin: const EdgeInsets.only(bottom: 0),
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(pictureUrl),
              backgroundColor: Colors.transparent,
            ),
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              userDesignation,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ));
  }

  Widget _buildMenuList(Menu menuItem) {
    //build the expansion tile
    double lp = 0; //left padding
    double fontSize = 16;
    Color iconColor = Colors.blue;
    if (menuItem.level == 1) {
      lp = 10;
      fontSize = 14;
      iconColor = Colors.green;
    }
    if (menuItem.level == 2) {
      lp = 20;
      fontSize = 12;
    }

    if (menuItem.children.isEmpty) {
      return Builder(builder: (context) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: lp),
            child: ListTile(
              leading: Icon(
                menuItem.icon,
                color: iconColor,
              ),
              title: Text(
                menuItem.title,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            if (checkAuth(menuItem.route)) {
              if (menuItem.route == "/logout") {
                Get.defaultDialog(
                  title: "Confirmation",
                  titleStyle: TextStyle(fontSize: 25),
                  middleText: "Are you sure to logout",
                  middleTextStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.white,
                  textCancel: "Cancel",
                  cancelTextColor: Colors.black,
                  textConfirm: "Confirm",
                  confirmTextColor: Colors.black,
                  onCancel: () {},
                  onConfirm: () {
                    LoginController.logout(email: email, authToken: token);
                  },
                  buttonColor: Colors.blue,
                );
              } else {
                Get.toNamed(menuItem.route);
              }
            } else {
              unAuthorized();
            }
          },
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(left: lp),
      child: ExpansionTile(
        leading: Icon(
          menuItem.icon,
          color: iconColor,
        ),
        title: Text(
          menuItem.title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        children: menuItem.children.map(_buildMenuList).toList(),
      ),
    );
  }

  List dataList = [
    //menu data item
    //Header
    {
      "level": 0,
      "icon": Icons.account_circle_rounded,
      "title": "  ",
    },

    //After Header Menu
    //menu data item
    {
      "level": 0,
      "icon": Icons.space_dashboard,
      "title": "Dashboard",
      "route": "/dashboard",
    },
    //menu data item
    {
      "level": 0,
      "icon": Icons.account_circle,
      "title": "HR",
      "children": [
        {
          "level": 1,
          "icon": Icons.account_box,
          "title": "Employees List",
          "route": "/employee_list",
        },
      ]
    },
    //menu data item
    {
      "level": 0,
      "icon": Icons.work_history_rounded,
      "title": "Power Projects",
      "children": [
        {
          "level": 1,
          "icon": Icons.format_list_numbered_outlined,
          "title": "Projects List",
          "route": "/project_list",
        },
        {
          "level": 1,
          "icon": Icons.document_scanner_outlined,
          "title": "All Projects Documents",
          "route": "/all_projects_documents",
        },
      ]
    },
    //menu data item
    {
      "level": 0,
      "icon": Icons.account_circle,
      "title": "Asset",
      "children": [
        {
          "level": 1,
          "icon": Icons.account_box,
          "title": "Asset List",
          "route": "/asset_list",
        },
      ]
    },
    //menu data item
    {
      "level": 0,
      "icon": Icons.logout_outlined,
      "title": "Logout",
      "route": "/logout",
    },
  ];
}
