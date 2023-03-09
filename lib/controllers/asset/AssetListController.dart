import 'dart:io';
import 'package:first_project/controllers/auth/UserPreferences.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_project/utils/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_project/modal/asset/AssetModal.dart';
import '../../utils/FileName.dart';

class AssetListController extends GetxController {
  UserPreference userPreference = UserPreference();
  var token = '';

  @override
  void onInit() {
    super.onInit();
    userPreference.getUser().then((value) => {token = value.token!});
  }

  @override
  void onClose() {}

  Future<List<AssetModal>> getAssetList({String? query}) async {
    String fileName = FileName.assetList;
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("Reading File from Device Cache");
      final data = file.readAsStringSync();
      Iterable responseData = jsonDecode(data);
      List<AssetModal> assets = List<AssetModal>.from(
          responseData.map((model) => AssetModal.fromJson(model))).toList();

      if (query != null) {
        assets = assets
            .where((element) => element
                .toJson()
                .toString()
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
      return assets;
    } else {
      print('fetching from API');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + token
      };
      var url = Uri.parse(BaseAPI.baseURL + EndPoints.assetList);
      http.Response response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        Iterable responseData = jsonDecode(response.body);
        List<AssetModal> assets = List<AssetModal>.from(
            responseData.map((model) => AssetModal.fromJson(model))).toList();

        if (query != null) {
          assets = assets
              .where((element) => element
                  .toJson()
                  .toString()
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
        return assets;
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    }
  }
}
