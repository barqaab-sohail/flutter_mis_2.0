import 'dart:convert';
import 'dart:io';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:first_project/utils/api/CustomException.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String _baseUrl = BaseAPI.baseURL;

  Future<dynamic> getHttp(String endPoint, String? token) async {
    var responseJson;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      var url = Uri.parse(_baseUrl + endPoint);
      final response = await http.get(url, headers: requestHeaders);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postHttp(String endPoint, String? token, Map? body) async {
    var responseJson;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      var url = Uri.parse(_baseUrl + endPoint);
      final response =
          await http.post(url, body: jsonEncode(body), headers: requestHeaders);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
