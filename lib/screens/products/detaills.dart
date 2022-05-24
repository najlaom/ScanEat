import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/services/bloc/cart_items.dart';
import 'package:scaneat/services/product_service.dart';
import 'package:scaneat/services/url_service.dart';

class Detaills extends StatefulWidget {
  String productId;
  Detaills(this.productId);

  @override
  State<Detaills> createState() => _DetaillsState();
}

class _DetaillsState extends State<Detaills> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String myOptionC = "";
  String myOptionF = "";
  String myOptionS = "";
  var selectedItem = [];
  bool dropUp = false;

  bool isValid = true;

  int quantity = 1;
  double total = 0;
  var product = {};
  List tableContent = [];
  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    _getProductsByDetails();
  }

  _isExiste(array1, array2) {
    if (isValid == true) return true;

    if (array2.length == 0) {
      return false;
    }
    var findArray = [];
    for (var i = 0; i < array1.length; i++) {
      findArray =
          array2.where((prd) => prd['name'] == array1[i]['name']).toList();
      if (findArray.length > 0) {
        return true;
      }
    }
    return false;
  }

  getNbrForms() {
    var nbr = 0;
    print('option_chaux');
    print(product['option_chaux']);
    if (product['option_chaux'] != null &&
        product['option_chaux'].length > 0 &&
        !_isExiste(product['option_chaux'], selectedItem)) {
      nbr++;
    }
    print('option_froid');
    print(product['option_froid']);
    if (product['option_froid'] != null &&
        product['option_froid'].length > 0 &&
        !_isExiste(product['option_froid'], selectedItem)) {
      nbr++;
    }
    print('option_sucre_sale');
    print(product['option_sucre_sale']);
    if (product['option_sucre_sale'] != null &&
        product['option_sucre_sale'].length > 0 &&
        !_isExiste(product['option_sucre_sale'], selectedItem)) {
      nbr++;
    }
    return nbr;
  }

  calculTotal() {
    double tmp = 0;
    tmp +=
        (product != null && product["price"] != null ? product["price"] : '') *
            (quantity);
    print('tmp');
    print(tmp);
    setState(() {
      total = tmp;
    });
  }

  _getProductsByDetails() async {
    print("_fetchProducts");
    var productDetails = await ProductService()
        .getProductByDetails(this.widget.productId.toString());
    print(productDetails.toString());
    if (productDetails.length > 0) {
      setState(() {
        product = productDetails;
      });
      print('product.toString()');
      print(product.toString());
    } else {
      setState(() {
        product = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xFFFF4C29),
        title: Text(
          product != null && product['name'] != null ? product['name'] : '',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
          textAlign: TextAlign.start,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: RefreshIndicator(
            key: refreshKey,
            backgroundColor: Colors.orange.shade100,
            color: Colors.white,
            onRefresh: refreshList,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height - 196,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75.0))),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,

                          //padding: EdgeInsets.all(10.0),
                          //color: Colors.red,
                          child: product != null &&
                                  product["productPicture"] != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    // border: Border.all(),
                                  ),
                                  child: Image.network(
                                    baseurl +
                                        "public/products/" +
                                        product["productPicture"],
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                        ),
                        Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                product != null && product["name"] != null
                                    ? product["name"]
                                    : '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                product != null && product["price"] != null
                                    ? product["price"].toString() + ' ' + 'TND'
                                    : '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5.0),
                                  child: product != null &&
                                          product['product_et'] != null
                                      ? ListView.builder(
                                          itemCount:
                                              product['product_et'].length,
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  product != null &&
                                                          product['product_et']
                                                                  [index] !=
                                                              null &&
                                                          product['product_et']
                                                                      [index]
                                                                  ['nom_et'] !=
                                                              null
                                                      ? product['product_et']
                                                          [index]['nom_et']
                                                      : '',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                    product != null &&
                                                            product['product_et']
                                                                        [index][
                                                                    'nom_et'] !=
                                                                null
                                                        ? ', '
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.grey))
                                              ],
                                            );
                                          })
                                      : Container(),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (getNbrForms() > 0)
                            ? Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.do_not_disturb,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Vous devez remplir les ' +
                                          getNbrForms().toString() +
                                          ' formulaires requis \n manquants.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        (product['option_chaux'] != null &&
                                product['option_chaux'].length > 0)
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('choisissez votre café'
                                              .toUpperCase()),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            'Choisir 1',
                                            style: TextStyle(
                                                color: (!_isExiste(
                                                        product['option_chaux'],
                                                        selectedItem))
                                                    ? Colors.red
                                                    : Color(0xFFFF4C29)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 2.0,
                                      child: Container(
                                        color: (!_isExiste(
                                                product['option_chaux'],
                                                selectedItem))
                                            ? Color(0xFFFF4C29)
                                            : Colors.orange.shade50,
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 60,
                                        child: Text(
                                          'Requis',
                                          style: TextStyle(
                                              color: (!_isExiste(
                                                      product['option_chaux'],
                                                      selectedItem))
                                                  ? Colors.white
                                                  : Color(0xFFFF4C29)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        (product['option_chaux'] != null &&
                                product['option_chaux'].length > 0)
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: product['option_chaux'].length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int indexC) {
                                      return Card(
                                        shape: (!_isExiste(
                                                product['option_chaux'],
                                                selectedItem))
                                            ? RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.red,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : null,
                                        elevation: 0.2,
                                        child: RadioListTile(
                                          title: Text(product != null &&
                                                  product['option_chaux']
                                                          [indexC]['name'] !=
                                                      null
                                              ? product['option_chaux'][indexC]
                                                  ['name']
                                              : ""),
                                          value: product['option_chaux'][indexC]
                                                  ['name']
                                              .toString(),
                                          groupValue: myOptionC,
                                          onChanged: (value) {
                                            setState(() {
                                              myOptionC = value.toString();
                                              selectedItem.add(
                                                  product['option_chaux']
                                                      [indexC]);
                                            });
                                            print("selectedItem[indexC]");
                                            print(selectedItem);
                                          },
                                          activeColor: Colors.green,
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                        (product['option_froid'] != null &&
                                product['option_froid'].length > 0)
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('choisissez votre jus'
                                              .toUpperCase()),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            'Choisir 1',
                                            style: TextStyle(
                                                color: (!_isExiste(
                                                        product['option_froid'],
                                                        selectedItem))
                                                    ? Colors.red
                                                    : Color(0xFFFF4C29)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 2.0,
                                      child: Container(
                                        color: (!_isExiste(
                                                product['option_froid'],
                                                selectedItem))
                                            ? Color(0xFFFF4C29)
                                            : Colors.orange.shade50,
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 60,
                                        child: Text(
                                          'Requis',
                                          style: TextStyle(
                                              color: (!_isExiste(
                                                      product['option_froid'],
                                                      selectedItem))
                                                  ? Colors.white
                                                  : Color(0xFFFF4C29)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        (product['option_froid'] != null &&
                                product['option_froid'].length > 0)
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: product['option_froid'].length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int indexF) {
                                      return Card(
                                        elevation: 0.2,
                                        shape: (!_isExiste(
                                                product['option_froid'],
                                                selectedItem))
                                            ? RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.red,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : null,
                                        child: RadioListTile(
                                          title: Text(product != null &&
                                                  product['option_froid']
                                                          [indexF]['name'] !=
                                                      null
                                              ? product['option_froid'][indexF]
                                                  ['name']
                                              : ""),
                                          value: product['option_froid'][indexF]
                                                  ['name']
                                              .toString(),
                                          groupValue: myOptionF,
                                          onChanged: (value) {
                                            setState(() {
                                              myOptionF = value.toString();
                                              selectedItem.add(
                                                  product['option_froid']
                                                      [indexF]);
                                            });
                                            print("selectedItem[indexF]");
                                            print(selectedItem);
                                          },
                                          activeColor: Colors.green,
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                        (product['option_sucre_sale'] != null &&
                                product['option_sucre_sale'].length > 0)
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('choisissez votre crêpe'
                                              .toUpperCase()),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          _isExiste(
                                                  product['option_sucre_sale'],
                                                  selectedItem)
                                              ? Text(
                                                  'Choisir 1',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Text('Choisir 1'),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 2.0,
                                      child: Container(
                                        color: (!_isExiste(
                                                product['option_sucre_sale'],
                                                selectedItem))
                                            ? Colors.red
                                            : Colors.orange.shade50,
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 60,
                                        child: Text(
                                          'Requis',
                                          style: TextStyle(
                                              color: (!_isExiste(
                                                      product[
                                                          'option_sucre_sale'],
                                                      selectedItem))
                                                  ? Colors.white
                                                  : Color(0xFFFF4C29)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        (product['option_sucre_sale'] != null &&
                                product['option_sucre_sale'].length > 0)
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        product['option_sucre_sale'].length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int indexS) {
                                      return Card(
                                        elevation: 0.2,
                                        shape: (!_isExiste(
                                                product['option_sucre_sale'],
                                                selectedItem))
                                            ? RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.red,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : null,
                                        child: RadioListTile(
                                          title: Text(product != null &&
                                                  product['option_sucre_sale']
                                                          [indexS]['name'] !=
                                                      null
                                              ? product['option_sucre_sale']
                                                  [indexS]['name']
                                              : ""),
                                          value: product['option_sucre_sale']
                                                  [indexS]['name']
                                              .toString(),
                                          groupValue: myOptionS,
                                          onChanged: (value) {
                                            setState(() {
                                              myOptionS = value.toString();
                                              selectedItem.add(
                                                  product['option_sucre_sale']
                                                      [indexS]);
                                            });
                                            print("selectedItem[indexS]");
                                            print(selectedItem);
                                          },
                                          activeColor: Colors.green,
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: Container(
                    height: 80.0,
                    color: Colors.white,
                    //padding: EdgeInsets.all(1.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            height: 50,
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  calculTotal();
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          width: 70,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            '$quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                fontSize: 20,
                                fontFamily: 'JosefinSans'),
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            height: 50,
                            onPressed: () {
                              setState(() {
                                quantity++;
                                calculTotal();
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          width: 70,
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                        ),
                        Container(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            height: 50,
                            onPressed: () {
                              var prd = product;
                              prd["quantity"] = quantity;
                              print("selectChoice");
                              prd["selectChoice"] = selectedItem;
                              print(prd["selectChoice"]);
                              if (prd['option_chaux'] != null &&
                                  prd['option_chaux'].length > 0 &&
                                  prd['option_froid'] != null &&
                                  prd['option_froid'].length > 0 &&
                                  prd['option_sucre_sale'] != null &&
                                  prd['option_sucre_sale'].length > 0) {
                                if (myOptionC != "" &&
                                    myOptionF != "" &&
                                    myOptionS != "") {
                                  setState(() {
                                    print('ffffffffffffffffffffffffff');
                                    bloc.addToCart(prd);
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  setState(() {
                                    isValid = !isValid;
                                    print('jjjjjjjjjjjjjjjjjjjjj');
                                  });
                                }
                              } else if (prd['option_chaux'] != null &&
                                  prd['option_chaux'].length > 0 &&
                                  prd['option_froid'] != null &&
                                  prd['option_froid'].length > 0) {
                                if (myOptionC != "" && myOptionF != "") {
                                  setState(() {
                                    print('ssssssssssssssssssss');
                                    bloc.addToCart(prd);
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  setState(() {
                                    isValid = !isValid;
                                    print('kkkkkkkkkkkkkkkkkkk');
                                  });
                                }
                              } else {
                                print('mmmmmmmmmmmmmmmmmmmmmm');
                                setState(() {
                                  bloc.addToCart(prd);
                                  Navigator.of(context).pop();
                                });
                              }
                              // if (getNbrForms() == 0){
                              //   bloc.addToCart(prd);
                              //   setState(() {
                              //     Navigator.of(context).pop();
                              //   });
                              // }
                              // else {
                              //   print('hellooooooo');
                              //   setState(() {
                              //     isValid = !isValid;
                              //   });
                              // }
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Ajouter',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'JosefinSans',
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                product != null && product['price'] != null
                                    ? Text(
                                        '${product['price'] * quantity}' +
                                            ' DT',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'JosefinSans',
                                            fontSize: 15),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          color: Color(0xFF36AE7C),
                          alignment: Alignment.center,
                          width: 200,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
