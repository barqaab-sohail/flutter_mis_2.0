import 'package:first_project/binding/Binding.dart';
import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/routes/PageRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/views/dashboard/DashboardView.dart';
import 'package:first_project/views/auth/LoginView.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MisApp());
}

var projectId;

class MisApp extends StatelessWidget {
  const MisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'BARQAAB MIS',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
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
