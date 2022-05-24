import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bloc = CartItemsBloc();

class CartItemsBloc {
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  List allItems = [];
  _saveCart() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("cart", json.encode(allItems));
    });
  }

  initCart() async {
    SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();
    var cartPref = prefs.getString("cart");
    if (cartPref != null) {
      print("cartPref");
      print(cartPref);
      var cart = json.decode(cartPref);
      if (cart != null && cart.length > 0) {
        allItems = [];
        //print("add from prefs");
        //print(cart);
        cart.forEach((c) {
          //addToCart(c);
          // print(c.toString());
          allItems.add(c);
        });
        // allItems = cart;
        //print("Cart not empty");
        cartStreamController.sink.add(allItems);
      }
    }
  }

  void emptyCart() {
    allItems = [];
    cartStreamController.sink.add(allItems);
    _saveCart();
  }
  Future<void> addToCart(item) async {
    print("item bloc");
    print(item);
    bool found = false;
    if (allItems.length > 0) {
      for (var i = 0; i < allItems.length; i++) {
        if (allItems[i] != null && allItems[i]["_id"] == item["_id"]) {
          found = true;
          await allItems[i]["quantity"]++;
          print("produiiiiiiiiiiiiiiiiiiiiiiiiiit ajouté");
        }
      }
    }
    if (!found) allItems.add(item);
    print("tttemhhhhhhhhhhhhhhh");
    print(item);
    for (var i = 0; i < allItems.length; i++) {
      print('allItems.toString()');
      print(allItems[i]['name'].toString());
      print("najllllllllllllldddddddddddd");
      print(allItems[i]['selectChoice']);
    }

    _saveCart();
    cartStreamController.sink.add(allItems);
  }
  // Future<void> addToCartOption(item) async {
  //   print("item bloc");
  //   print(item);
  //
  //   // print('selectItem');
  //   // print(selectItem);
  //   bool found = false;
  //   if (allItems.length > 0) {
  //     for (var i = 0; i < allItems.length; i++) {
  //       if (allItems[i] != null && allItems[i]["_id"] == item["_id"]) {
  //         found = true;
  //         await allItems[i]["quantity"]++;
  //         print("produiiiiiiiiiiiiiiiiiiiiiiiiiit ajouté");
  //       }
  //     }
  //   }
  //   if (!found) allItems.add(item);
  //   print("item");
  //   print(item);
  //   for (var i = 0; i < allItems.length; i++) {
  //     print('allItems.toString()');
  //     // print(allItems[i]['sub_product'][i]['sub_name']);
  //     print(allItems[i]['name'].toString());
  //   }
  //
  //   _saveCart();
  //   cartStreamController.sink.add(allItems);
  // }

  getTotalItemFromCart(){
    double tmp = 0;
    print('allItemsssssss');
    if(allItems!= null)allItems.forEach((prdt) {
      tmp += prdt["quantity"] * prdt["price"];
    });
      return tmp;
  }
  getQuantityItemFromCart(idPrd) {
    print('allItemsss');
    print(allItems);
    // List quntitiesItem = allItems.where((item) => item["_id"] == idPrd).toList();
    for (var i = 0; i < allItems.length; i++) {
      if (allItems[i] != null && allItems[i]["_id"] == idPrd) {
        print('idPrd');
        print(idPrd);
        print('allItems[i]quantity');
        print(allItems[i]['quantity']);
        var quantitiesItem = allItems[i]['quantity'];
        print('quantitiesItem');
        print('price');
        print(allItems[i]['price']);
        print(quantitiesItem);
        return quantitiesItem;

      }
    }
    // print('quntitiesItem');
    // print(quntitiesItem);
    // print("idprd");
    // print(idPrd);
    // print(quntitiesItem.length);
    // return quntitiesItem.length;
  }

  void clearItem(item) {
    print('removeItem');
    if (allItems.length > 0) {
      allItems.remove(item);
    }
  }

  void removeFromProduct(item) {
    print("remove iteme");
    print(item);
    if (allItems.length > 0) {
      for (var i = 0; i < allItems.length; i++) {
        if (allItems[i] != null &&
            allItems[i]["_id"] == item["_id"] &&
            allItems[i]["quantity"] > 1) {
          print(allItems[i]["quantity"]);
          allItems[i]["quantity"] = allItems[i]["quantity"]--;
          print(allItems[i]["quantity"]--);

          //allItems.removeAt(allItems[i]["quantity"]);
          cartStreamController.sink.add(allItems);
          _saveCart();
          return;
        } else if (allItems[i]["quantity"] == 0) {
          allItems.removeAt(i);
        }
      }
    }
    // print("Qt: "+item.quantity.toString());
    // allItems.remove(item);
  }

  void deletItem(item) {
    if (allItems.length > 0) {
      for (var i = 0; i < allItems.length; i++) {
        if (allItems[i] != null && allItems[i]["_id"] == item["_id"]) {
          allItems.removeAt(i);
          cartStreamController.sink.add(allItems);
          _saveCart();
          return;
        }
      }
    }
    // print("Qt: "+item.quantity.toString());
    // allItems.remove(item);
  }

  void dispose() {
    cartStreamController.close(); // close our StreamController
  }

  void minuxFromCart(item) {
    if (allItems.length > 0) {
      for (var i = 0; i < allItems.length; i++) {
        if (allItems[i] != null && allItems[i]["_id"] == item["_id"]) {
          allItems[i]["quantity"]--;
          if (allItems[i]["quantity"] <= 0) {
            allItems.remove(item);
            break;
          }
        }
      }
    }

    cartStreamController.sink.add(allItems);
    _saveCart();
  }
}
