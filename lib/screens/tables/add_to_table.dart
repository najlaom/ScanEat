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
    bloc.allItems.forEach((prdt) {
      tmp += prdt["quantity"] * prdt["price"];
    });
    setState(() {
      total = tmp;
    });
  }

  getStringArray(array) {
    List _isSelected = [];
    for(var i = 0; i < array.length; i++) {
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
    var prdClient = await TableService().addtoTable(items, total.toString(), id_gerant);
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
      body: Stack(
        children: [
          ListView(
            children: [
              ...tableContent
                  .map((e) => Column(
                        children: [
                          _buildProduct(e),
                        ],
                      ))
                  .toList(),
              _buildDivider(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const SizedBox(width: 40.0),
                  Text(
                    "Total",
                    style: priceTextStyle.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "$total" + "" + "TND",
                    style: priceTextStyle.copyWith(color: Colors.indigo),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Color(0xFF082032),
                  child: Text(
                    "valider".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () async {
                    await _addToTable();
                    bloc.emptyCart();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) => Order(id_Table,)),
                            (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
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
        height: 90,
        child: ListTile(
            leading: Container(
              width: 110,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      bloc.deletItem(product);
                      setState(() {
                        calculTotal();
                        tableContent = bloc.allItems;
                      });
                    },
                    child: Icon(Icons.close,color: Colors.black),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: product['productPicture'] != null
                        ? Image.network(
                      baseurl + "public/products/" + product["productPicture"],
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    )
                        : null,
                  ),
                ],
              ),
            ),
            title: Container(
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product['price'] * product['quantity']}" + ' ' + "TD",
                        style: priceTextStyle,
                      ),
                    ],
                  ),
                  Expanded(child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product['selectChoice'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(product['selectChoice'][index]['name']+ ', ');
                      })),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 30.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 18.0,
                          padding: const EdgeInsets.all(2.0),
                          icon: Icon(Icons.remove),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        IconButton(
                          iconSize: 18.0,
                          padding: const EdgeInsets.all(2.0),
                          icon: Icon(Icons.add),
                          onPressed: () {
                            bloc.addToCart(product);
                            setState(() {
                              calculTotal();
                              tableContent = bloc.allItems;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
