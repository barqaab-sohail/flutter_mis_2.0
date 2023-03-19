import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'BaseAPI.dart';

String baseUrl = BaseAPI.baseURL;

class BaseClient {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api, String? token) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> post(String api, dynamic object, String? token) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await client.post(url, body: _payload, headers: _headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        //throw exception and catch it in UI
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object, String? token) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> delete(String api, String? token) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}
