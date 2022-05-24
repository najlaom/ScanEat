import 'package:scaneat/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TableService {
  late SharedPreferences sharedPreferences;

  Future<bool> _saveTableInfos(tableinfos) async {
    print("tableinfos : ");
    print(tableinfos);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tableid", tableinfos["_id"]);
    prefs.setString("numTable", tableinfos["num_table"]);
    prefs.setString("state", tableinfos["state"]);
    prefs.setString("etaTable", tableinfos["etat_table"]);
    prefs.setString("idEspace", tableinfos["manager_espace_client"]["_id"]);

    return true;
  }

  Future<dynamic> getTableInfos() async {
    return SharedPreferences.getInstance().then((prefs) {
      var table = new Map();
      table["tableid"] = prefs.getString("tableid");
      table["numTable"] = prefs.getString("numTable");
      table["state"] = prefs.getString("state");
      table["etaTable"] = prefs.getString("etaTable");
      table["idEspace"] = prefs.getString("idEspace");
      return table;
    });
  }

  Future<bool> _saveTableServerInfos(tableinfos) async {
    print("tableinfos : ");
    print(tableinfos);

    SharedPreferences prefsServer = await SharedPreferences.getInstance();
    prefsServer.setString("tableid", tableinfos["_id"]);
    prefsServer.setString("numTable", tableinfos["num_table"]);
    prefsServer.setString("state", tableinfos["state"]);
    prefsServer.setString("etaTable", tableinfos["etat_table"]);
    prefsServer.setString("idServer", tableinfos["server"]["_id"]);
    prefsServer.setString("firstnameServer", tableinfos["server"]["firstName"]);
    prefsServer.setString("lastnameServer", tableinfos["server"]["lastName"]);
    prefsServer.setString("usernameServer", tableinfos["server"]["username"]);
    prefsServer.setString("roleServer", tableinfos["server"]["role"]);
    prefsServer.setString("idEspace", tableinfos["manager_espace_client"]["_id"]);

    return true;
  }

  Future<dynamic> getTableServerInfos() async {
    return SharedPreferences.getInstance().then((prefsServer) {
      var tableServer = new Map();
      tableServer["tableid"] = prefsServer.getString("tableid");
      tableServer["numTable"] = prefsServer.getString("numTable");
      tableServer["state"] = prefsServer.getString("state");
      tableServer["etaTable"] = prefsServer.getString("etaTable");
      tableServer["idServer"] = prefsServer.getString("idServer");
      tableServer["firstnameServer"] = prefsServer.getString("firstnameServer");
      tableServer["lastnameServer"] = prefsServer.getString("lastnameServer");
      tableServer["usernameServer"] = prefsServer.getString("usernameServer");
      tableServer["roleServer"] = prefsServer.getString("roleServer");
      tableServer["idEspace"] = prefsServer.getString("idEspace");

      return tableServer;
    });
  }

  Future getTableByDetails(String tableId) async {
    print("tableId");
    print(tableId);
    String url = baseurl + 'api/tables/tableId/' + tableId;
    print("urlllllllllllllll");
    print(url);
    var tableByDetaills = await http.post(Uri.parse(url));
    print("productByDetaills");
    print(tableByDetaills.body);
    if (tableByDetaills.statusCode == 200) {
      print(tableByDetaills.body);
      var jsonResp = json.decode(tableByDetaills.body);
      print("loginResponsebody");
      print(jsonResp.toString());
      if (jsonResp != null) {
        var tableDatas = jsonResp["result"];
        print(jsonResp.toString());
        print('tableDatas["_id"]');
        print(tableDatas["_id"]);
        if (tableDatas["_id"] != null) {
          var savedDatas = await _saveTableInfos(tableDatas);
          if (savedDatas) {
            print("Now return !!! ");
            return tableDatas;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else
        return [];
    } else
      return [];
  }

  Future getTable(String tableId) async {
    print("tableId");
    print(tableId);
    String url = baseurl + 'api/tables/tableId/' + tableId;
    print("urlllllllllllllll");
    print(url);
    var table = await http.post(Uri.parse(url));
    print("table");
    print(table.body);
    if (table.statusCode == 200) {
      print(table.body);
      var jsonResp = json.decode(table.body);
      print("loginResponsebody");
      print(jsonResp.toString());
      if (jsonResp["success"] == true && jsonResp["result"].length > 0) {
        print(jsonResp.toString());
        return jsonResp["result"];
      } else
        return [];
    } else
      return [];
  }

  Future getTableByOrder(String tableId) async {
    print("tableId");
    print(tableId);
    String url = baseurl + 'api/tables/table-order/' + tableId;
    print("urlllllllllllllll");
    print(url);
    var tableByDetaills = await http.post(Uri.parse(url));
    print("productByDetaills");
    print(tableByDetaills.body);
    if (tableByDetaills.statusCode == 200) {
      print(tableByDetaills.body);
      var jsonResp = json.decode(tableByDetaills.body);
      print("loginResponsebody");
      print(jsonResp.toString());
      if (jsonResp["success"] == true && jsonResp["result"].length > 0) {
        print(jsonResp.toString());
        //najla
        return jsonResp["result"];
      } else
        return [];
    } else
      return [];
  }

  Future getTableServerByDetails(String tableId) async {
    print("tableId");
    print(tableId);
    String url = baseurl + 'api/tables/table-server/' + tableId;
    print("urlllllllllllllll");
    print(url);
    var tableByDetaills = await http.post(Uri.parse(url));
    print("productByDetaills");
    print(tableByDetaills.body);
    if (tableByDetaills.statusCode == 200) {
      print(tableByDetaills.body);
      var jsonResp = json.decode(tableByDetaills.body);
      print("loginResponsebody");
      print(jsonResp.toString());
      if (jsonResp != null) {
        var tableDatas = jsonResp["result"];
        print(jsonResp.toString());
        print('tableDatas["_id"]');
        print(tableDatas["_id"]);
        if (tableDatas["_id"] != null) {
          var savedDatas = await _saveTableServerInfos(tableDatas);
          if (savedDatas) {
            print("Now return !!! ");
            return tableDatas;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else
        return [];
    } else
      return [];
  }

  Future addtoTable(products, totalCmd, idGerant) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var idTable = sharedPreferences.getString("tableid");
    print("tableid");
    print(idTable);

    String url = baseurl + 'api/tables/table/addcommande/' + idTable.toString();
    print("urlllllllllllllll");
    print(url);
    var tableByDetaills = await http.post(Uri.parse(url),
        body: {"orders": json.encode(products), "total": totalCmd, "idGerant": idGerant});
    print("productByDetaills");
    print(tableByDetaills.body);
    if (tableByDetaills.statusCode == 200) {
      print("productByDetaills.body");
      print(tableByDetaills.body);
      var jsonTableByDetails = json.decode(tableByDetaills.body);
      print("aaaaaaaaaaaaaaaa");
      print(jsonTableByDetails.toString());
      if (jsonTableByDetails["success"] == true &&
          jsonTableByDetails["data"].length > 0) {
        print(jsonTableByDetails.toString());
        //najla
        return jsonTableByDetails["data"];
      } else
        return [];
    } else
      return [];
  }

  Future<bool> _saveTableOrderInfos(tableOrderinfos) async {
    print("tableOrderinfos : ");
    print(tableOrderinfos);

    SharedPreferences prefsOrder = await SharedPreferences.getInstance();
    var index = 0;
    prefsOrder.setString("tableid", tableOrderinfos["_id"]);
    prefsOrder.setString("numTable", tableOrderinfos["num_table"]);
    prefsOrder.setString("state", tableOrderinfos["state"]);
    prefsOrder.setString("etaTable", tableOrderinfos["etat_table"]);
    prefsOrder.setString("idOrders", tableOrderinfos["orders"][index]['_id']);
    prefsOrder.setString("refCmd", tableOrderinfos["orders"][index]['ref_cmd']);
    prefsOrder.setString(
        "prixCmd", tableOrderinfos["orders"][index]['prix'].toString());
    prefsOrder.setString("etatCmd", tableOrderinfos["orders"][index]['etat']);
    prefsOrder.setString("dateCmd",
        tableOrderinfos["orders"][index]['date_commande'].toString());
    prefsOrder.setString("idtableItems",
        tableOrderinfos["orders"][index]['tableItems'][index]['_id']);
    prefsOrder.setString(
        "quantityItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['quantity']
            .toString());
    prefsOrder.setString(
        "priceItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['price']
            .toString());
    prefsOrder.setString(
        "idProductItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['product']['_id']
            .toString());
    prefsOrder.setString(
        "nameProductItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['product']['name']
            .toString());
    prefsOrder.setString(
        "productPictureProductItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['product']
                ['productPicture']
            .toString());
    prefsOrder.setString(
        "idCategoryProductItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['product']
                ['category']['_id']
            .toString());
    prefsOrder.setString(
        "slugCategoryProductItem",
        tableOrderinfos["orders"][index]['tableItems'][index]['product']
                ['category']['slug']
            .toString());

    return true;
  }

  Future<dynamic> getOrdersInfos() async {
    return SharedPreferences.getInstance().then((prefsOrder) {
      var table = new Map();
      table["tableid"] = prefsOrder.getString("tableid");
      table["numTable"] = prefsOrder.getString("numTable");
      table["state"] = prefsOrder.getString("state");
      table["etaTable"] = prefsOrder.getString("etaTable");
      // table["idOrders"] = prefsOrder.getString("idOrders");
      table["refCmd"] = prefsOrder.getString("refCmd");
      table["prixCmd"] = prefsOrder.getString("prixCmd");
      table["etatCmd"] = prefsOrder.getString("etatCmd");
      table["dateCmd"] = prefsOrder.getString("dateCmd");
      table["idtableItems"] = prefsOrder.getString("idtableItems");
      table["quantityItem"] = prefsOrder.getString("quantityItem");
      table["priceItem"] = prefsOrder.getString("priceItem");
      table["idProductItem"] = prefsOrder.getString("idProductItem");
      table["nameProductItem"] = prefsOrder.getString("nameProductItem");
      table["productPictureProductItem"] =
          prefsOrder.getString("productPictureProductItem");
      table["idCategoryProductItem"] =
          prefsOrder.getString("idCategoryProductItem");
      table["slugCategoryProductItem"] =
          prefsOrder.getString("slugCategoryProductItem");

      return table;
    });
  }

  Future getTableByOrders(String tableId) async {
    print("tableId");
    print(tableId);
    String url = baseurl + 'api/tables/table-order/' + tableId;
    print("urlllllllllllllll");
    print(url);
    var tableByDetaills = await http.post(Uri.parse(url));
    print("productByDetaills");
    print(tableByDetaills.body);
    if (tableByDetaills.statusCode == 200) {
      print(tableByDetaills.body);
      var jsonResp = json.decode(tableByDetaills.body);
      print("loginResponsebody");
      print(jsonResp.toString());
      if (jsonResp != null) {
        var tableDataOrders = jsonResp["result"];
        print(jsonResp.toString());
        print('tableDataOrders["_id"]');
        print(tableDataOrders["_id"]);
        if (tableDataOrders["_id"] != null) {
          var savedDataOrders = await _saveTableOrderInfos(tableDataOrders);
          if (savedDataOrders) {
            print("Now return !!! ");
            return tableDataOrders;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else
        return [];
    } else
      return [];
  }
}
