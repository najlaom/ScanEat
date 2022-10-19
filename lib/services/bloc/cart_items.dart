import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

final bloc = CartItemsBloc();

class CartItemsBloc {
  final cartStreamController = StreamController.broadcast();

  Function eq = const ListEquality().equals;

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

  getTotalItemFromCart() {
    double tmp = 0;
    print('allItemsssssss');
    if (allItems != null) {
      allItems.forEach((prdt) {
        tmp += prdt["quantity"] * prdt["price"];
      });
      return tmp;
    } else {
      print('vidddddddddddddddddddddddddddddddddddd');
    }
  }

  countItem(array) {
    array = allItems;
    if (array == null) {
      return 0;
    } else {
      int count = 0;
      for (var i = 0; i < array.length; i++) {
        count += int.parse(array[i]["quantity"].toString());
      }
      return count;
    }
  }

  getQuantityItemFromCart(array, idPrd) {
    array = allItems;
    if (array == null) {
      return 0;
    } else {
      int count = 0;
      for (var i = 0; i < array.length; i++) {
        if (array[i] != null && array[i]["_id"] == idPrd) {
          count += int.parse(array[i]["quantity"].toString());
          print('allItems.lengthcoooooooooooooooooooooooo');
          print(allItems);
          print(allItems.length);
          print('araaaaaaaaaaaaaaaaaaaaaaaay');
          print(array.length);
          print(count);
          print(count);
        }
      }
      print('allItems.lengthcoooooooooooooooooooooooo');
      print(allItems.length);
      return count;
    }
  }

  Future<void> addToCart(item) async {
    print("najla");
    print(item);
    bool found = false;
    if (item.length > 0) {
      print('fffffffffffffffff');
      print(item);
      if (item['selectChoice'].length == 0) {
        print('viddddddddddddddddddddddddd');
        print(item['selectChoice']);
        for (var i = 0; i < allItems.length; i++) {
          if (allItems[i] != null && allItems[i]["_id"] == item["_id"] && allItems[i]["selectChoice"].length == 0) {
            found = true;
            print('allItems[i]["quantity"]vvvvvvvvvvvvvvvvvvvvvvvvv');
            print(allItems[i]["quantity"]);
            allItems[i]["quantity"] += item["quantity"];
          }
        }
      } else {
        print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        print(item['selectChoice']);
        for (var i = 0; i < allItems.length; i++) {
          // for(var j = 0; j < allItems[i]['selectChoice'].length; j++){
          //   print("allItems[i]['selectChoice'][j]['_id']");
          //   print(allItems[i]['selectChoice'][j]["_id"]);
          //   if(allItems[i]['selectChoice'][j]["_id"] == item['selectChoice'][j]["_id"]){
          //     found = true;
          //     j ++;
          //     allItems[i]["quantity"]++;
          //   }
          // }
          if (allItems[i]['selectChoice'].length > 0 && compareTwoArray(allItems[i]['selectChoice'], item["selectChoice"]) == true) {
            found = true;
            print('ddddddddddddddddddddddddddddddajjjjjjjjjjjjjjjjjjjjjj');
            allItems[i]["quantity"] += item["quantity"];
          }
        }
      }
    }
    if (!found) allItems.add(item);

    _saveCart();
    cartStreamController.sink.add(allItems);
  }

  bool compareTwoArray(array1, array2) {
    var list = [];
    for (var item in array1) {
      list = array2
          .where((choiceItem) => choiceItem["_id"] == item["_id"])
          .toList();
      if (list.length == 0) return false;
    }
    return true;
  }

  Future<void> addOneItem(item) async {
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
    _saveCart();
    cartStreamController.sink.add(allItems);
  }

  Future<void> addToCartOption(item) async {
    print("item bloc");
    print(item);

    // print('selectItem');
    // print(selectItem);
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
    print("item");
    print(item);
    for (var i = 0; i < allItems.length; i++) {
      print('allItems.toString()');
      // print(allItems[i]['sub_product'][i]['sub_name']);
      print(allItems[i]['name'].toString());
    }

    _saveCart();
    cartStreamController.sink.add(allItems);
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
