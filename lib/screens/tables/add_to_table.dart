import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/orders/order.dart';
import 'package:scaneat/services/bloc/cart_items.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final priceTextStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

class AddToTable extends StatefulWidget {
  final product;
  final idProduct;
  AddToTable({this.idProduct, this.product});
  @override
  _AddToTableState createState() => _AddToTableState();
}

class _AddToTableState extends State<AddToTable> {
  List tableContent = [];
  double total = 0;
  bool loading = true;
  final storage = new FlutterSecureStorage();
  bool connected = false;
  var numTable = '';
  var id_Table = '';
  var id_gerant = '';
  // void _loadData() async {
  //   String value = await storage.read(key: "token");
  //   if (value == null) {
  //     setState(() {
  //       connected = false;
  //     });
  //   } else {
  //     setState(() {
  //       connected = true;
  //     });
  //   }
  //   await Future.delayed(const Duration(seconds: 5));
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    tableContent = bloc.allItems;
    calculTotal();
    // _loadData();
    _checkScannerTable();
  }

  calculTotal() {
    double tmp = 0;
    if (bloc.allItems != null) {
      bloc.allItems.forEach((prdt) {
        tmp += prdt["quantity"] * prdt["price"];
      });
    }
    setState(() {
      total = tmp;
    });
  }

  getStringArray(array) {
    List _isSelected = [];
    for (var i = 0; i < array.length; i++) {
      _isSelected.add(array[i]["name"]);
    }
    return _isSelected;
  }

  _addToTable() async {
    List items = [];
    print("bloc.allItems : ");
    print(bloc.allItems);
    List _isSelected = [];

    for (var i = 0; i < bloc.allItems.length; i++) {
      print('fgggggggghhhhhhhh');
      print(bloc.allItems[i]['selectChoice']);
      _isSelected = getStringArray(bloc.allItems[i]['selectChoice']);
      print('_isSelected');
      print(_isSelected);
    }
    print('items : ');
    print(items.toString());
    bloc.allItems.forEach((e) {
      items.add({
        "product": e["_id"],
        "quantity": e["quantity"],
        "price": e["price"] * e["quantity"],
        "selectChoice": _isSelected
      });
      print('ioeeeeeeeeeeeeetems');
      print(items);
    });
    var prdClient =
        await TableService().addtoTable(items, total.toString(), id_gerant);
    print('fffffffffffffffff');
    print(items);
    print("idProdddddddddddddddt");
    print(prdClient);
    print(prdClient.toString());
  }

  _checkScannerTable() async {
    var tableDetails = await TableService().getTableInfos();
    print("tableDetailsssss");
    print(tableDetails);
    if (tableDetails.isNotEmpty &&
        tableDetails["tableid"] != null &&
        tableDetails["numTable"] != null) {
      print('tableid');
      print(tableDetails["tableid"]);
      numTable = tableDetails["numTable"];
      print("numTable");
      print(numTable);
      id_Table = tableDetails["tableid"];
      print('id_gerant');
      id_gerant = tableDetails["idEspace"];
      print(id_gerant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xFFFF4C29),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Commande',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.86,
            child: ListView(
              children: [
                ...tableContent
                    .map((e) => Column(
                          children: [
                            _buildProduct(e),
                          ],
                        ))
                    .toList(),
              ],
            ),
          ),
          Card(
            elevation: 4.0,
            child: Container(
              height: 110.0,
              color: Colors.white,
              //padding: EdgeInsets.all(1.0),
              child: Column(
                children: [
                  _buildDivider(),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              color: Color(0xFF082032),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 1.5,
                              fontFamily: 'JosefinSans'),
                        ),
                        Spacer(),
                        Text(
                          "$total" + "" + " TND",
                          style: TextStyle(
                              color: Color(0xFF082032),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 1.5,
                              fontFamily: 'JosefinSans'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 350,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Color(0xFF00C092),
                      child: Text(
                        "Valider",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 24.0,
                            height: 1.5),
                      ),
                      onPressed: () async {
                        await _addToTable();
                        bloc.emptyCart();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Order(
                                      id_Table,
                                    )),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Widget _buildProduct(product) {
    return Card(
      elevation: 1.0,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          visualDensity: VisualDensity(horizontal: -4, vertical: 0),
          contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
          title: Row(
            children: [
              Text(
                product['name'] != null ? product['name'] : "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${product['price'] * product['quantity']}" + ' ' + "TD",
                style: priceTextStyle,
              ),
            ],
          ),
          subtitle: Container(
            height: 70,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 5.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: product['selectChoice'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(product['selectChoice'][index]['name']+ ', ');
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00C092),
                          shape: const CircleBorder(),
                          // padding: const EdgeInsets.all(30)
                          minimumSize: Size(5, 5)
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 24,
                      ),
                      onPressed: () {
                        bloc.removeFromProduct(product);
                        setState(() {
                          calculTotal();
                          tableContent = bloc.allItems;
                        });
                      },
                    ),
                    Text(
                      "${product['quantity']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00C092),
                          shape: const CircleBorder(),
                          // padding: const EdgeInsets.all(30)
                          minimumSize: Size(5, 5)
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 24,
                      ),
                      onPressed: () {
                        bloc.addOneItem(product);
                        setState(() {
                          calculTotal();
                          tableContent = bloc.allItems;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          leading: product['productPicture'] != null
              ? Image.network(
                  baseurl + "public/products/" + product["productPicture"],
                  fit: BoxFit.cover,
                  height: 90,
                  width: 70,
                )
              : null,
          trailing: Container(
            padding: EdgeInsets.all(0.0),
            width: 35,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                bloc.deletItem(product);
                setState(() {
                  calculTotal();
                  print('tableccccccccccccccccccccccccccccccc');
                  print(tableContent);
                  tableContent = bloc.allItems;
                });
              },
              child: Icon(Icons.close, color: Colors.black, size: 25,),
            ),
          ),
        ),
      ),
    );
  }
}
