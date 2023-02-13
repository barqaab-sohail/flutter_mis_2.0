import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:first_project/views/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_project/views/dashboard/Dashboard.dart';
import 'binding/Binding.dart';

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
        initialBinding: InitialBinding(),
        getPages: [
          GetPage(name: Routes.LOGIN_SCREEN, page: () => const LoginScreen()),
          GetPage(name: Routes.DASHBAORD, page: () => const DashBoardScreen()),
        ],
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

class Routes {
  static const String LOGIN_SCREEN = "/";
  static const String DASHBAORD = "/dashboard";
}
