import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/routes/PageRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/views/dashboard/Dashboard.dart';
import 'package:first_project/views/auth/LoginScreen.dart';

void main() async {
  runApp(MisApp());
}

class MisApp extends StatelessWidget {
  const MisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        // initialRoute: Routes.DASHBAORD,
        home: FutureBuilder(
          future: LoginController.isLogin(),
          builder: (context, authResult) {
            if (authResult.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              );
            } else {
              if (authResult.data == true) {
                return DashBoardScreen();
              } else {
                return LoginScreen();
              }
            }
          },
        ));
  }
}
