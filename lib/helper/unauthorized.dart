import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnAuthorized {
  static authError() {
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
}
