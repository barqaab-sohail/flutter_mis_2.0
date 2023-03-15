import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/model/asset/AssetModel.dart';

class AssetListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<AssetModal> _assets = [];
  List<AssetModal> filterAsset = [];

  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}

  Future<List<AssetModal>> getAssetList({String? query}) async {
    if (_assets.isNotEmpty) {
      print('asset list call from save variable');
      if (query != null) {
        filterAsset = _assets
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterAsset;
      }
      return _assets;
    }
    print('fetching from API');
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
