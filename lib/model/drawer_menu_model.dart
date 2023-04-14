import 'package:flutter/material.dart';

class Menu {
  int level = 0;
  IconData icon = Icons.drive_file_rename_outline;
  String title = "";
  String route = "";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.route, this.children);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if (json["level"] != null) {
      level = json["level"];
    }
    //icon
    if (json["icon"] != null) {
      icon = json["icon"];
    }
    //route
    if (json["route"] != null) {
      route = json["route"];
    }
    //title
    title = json['title'];
    //children
    if (json['children'] != null) {
      children.clear();
      //for each entry from json children add to the Node children
      json['children'].forEach((v) {
        children.add(Menu.fromJson(v));
      });
    }
  }
}
