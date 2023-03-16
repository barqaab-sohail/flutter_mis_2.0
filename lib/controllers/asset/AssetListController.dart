import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/model/asset/AssetModal.dart';

class AssetListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';
  List<AssetModal> assets = [];
  List<AssetModal> filterAssets = [];

  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}

  Future<List<AssetModal>> getAssetList({String? query}) async {
    if (assets.isNotEmpty) {
      if (query != null) {
        filterAssets = assets
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
        return filterAssets;
      }
      return assets;
    }
    print('fetching from API');
    print(token);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    print(requestHeaders);
    var url = Uri.parse(BaseAPI.baseURL + EndPoints.assetList);
    http.Response response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      Iterable responseData = jsonDecode(response.body);
      assets = List<AssetModal>.from(
          responseData.map((model) => AssetModal.fromJson(model))).toList();

      return assets;
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }
}
