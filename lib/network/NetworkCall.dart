import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:first_project/network/AppException.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://localhost/hrms/public/api/";

  Future<dynamic> get(String endPoint) async {
    var responseJson;
    try {
      var url = Uri.parse(_baseUrl + endPoint);
      final response = await http.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
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
