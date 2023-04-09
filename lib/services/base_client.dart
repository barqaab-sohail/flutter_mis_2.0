import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:first_project/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class BaseClient extends BaseController {
  static const int TIME_OUT_DURATION = 20;
  //GET
  Future<dynamic> get(String baseUrl, String api, {String? token = ''}) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj,
      {String? token = ''}) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = payloadObj;
    try {
      var response = await http
          .post(uri,
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              body: payload)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        hideLoading();
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid Email or Password'),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
        // throw UnAuthorizedException(
        //     utf8.decode(response.bodyBytes), response.request!.url.toString());
        break;
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
