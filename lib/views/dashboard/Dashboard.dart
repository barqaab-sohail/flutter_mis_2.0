import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.backpack)),
        centerTitle: true,
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                LoginController.logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
