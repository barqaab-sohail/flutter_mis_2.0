import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/model/asset/AssetModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetListController extends GetxController {
  List<AssetModal> _assets = [];
  List<AssetModal> filterAssets = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  Future<List<AssetModal>> getAssetList({String? query}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token') ?? '';
    if (_assets.isNotEmpty) {
      if (query != null) {
        filterAssets = _assets
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterAssets;
      }
      return _assets;
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    var url = Uri.parse(BaseAPI.baseURL + EndPoints.assetList);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      _assets = List<AssetModal>.from(
          responseData.map((model) => AssetModal.fromJson(model))).toList();

      return _assets;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
