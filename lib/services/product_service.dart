import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:scaneat/services/url_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  late SharedPreferences sharedPreferences;


  Future getProductsByCategory(String catId) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var idEspace = sharedPreferences.getString("idEspace");
    print("idEspace");
    print(idEspace);
    var url = baseurl + 'api/products/product-category/'+ catId ;
    print("urlllllllllllllllproductBycattt");
    print(url);
    var products = await http.post(Uri.parse(url), body: {"idGerant": idEspace});
    print("products");
    print(products.body);
    if (products.statusCode == 200) {
      print("products.body");
      print(products.body);
      var jsonProducts = json.decode(products.body);
      print("aaaaaaaaaaaaaaaacatttttttttttttttt");
      print(jsonProducts.toString());
      if (jsonProducts["success"] == true &&
          jsonProducts["result"].length > 0) {
        print(jsonProducts.toString());

        return jsonProducts["result"];
      } else
        return [];
    } else
      return [];
  }
  Future getProductByDetails(String productId) async {

    var url = baseurl+'api/products/product/' + productId;
    var productByDetaills = await http.post(Uri.parse(url));
    if (productByDetaills.statusCode == 200) {
      print("productByDetaills.body");
      print(productByDetaills.body);
      var jsonproductByDetails = json.decode(productByDetaills.body);
      if (jsonproductByDetails["success"] == true &&
          jsonproductByDetails["result"].length > 0) {
        print(jsonproductByDetails.toString());

        return jsonproductByDetails["result"];
      } else
        return [];
    } else
      return [];
  }

}