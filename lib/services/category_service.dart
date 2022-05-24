import 'package:scaneat/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  late SharedPreferences sharedPreferences;

  Future getCategories() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var idEspace = sharedPreferences.getString("idEspace");
    print("idEspace");
    print(idEspace);
    var url = baseurl + 'api/categories/categories-espace/' + idEspace.toString();
    print("urlllllllllllllll");
    print(url);
    var categories = await http.post(Uri.parse(url));
    print("categories");
    print(categories.body);
    if (categories.statusCode == 200) {
      print("categories.body");
      print(categories.body);
      var jsonCategories = json.decode(categories.body);
      print("aaaaaaaaaaaaaaaa");
      print(jsonCategories.toString());
      if (jsonCategories["success"] == true &&
          jsonCategories["result"].length > 0) {
        print(jsonCategories.toString());

        return jsonCategories["result"];
      } else
        return [];
    } else
      return [];
  }
}