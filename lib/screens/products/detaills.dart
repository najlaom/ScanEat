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
  var optionC = null;
  String myOptionF = "";
  var optionF = null;
  String myOptionS = "";
  var optionS = null;
  var selectedItem = [];
  var selectedItemC = [];
  var selectedItemF = [];
  var selectC = [];
  var selectF = [];
  bool dropUp = false;
  bool isSelectedC = false;
  bool isSelectedF = false;
  bool isSelectedS = false;
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

  // _isExiste(array1, array2) {
  //   if (isValid == true) return true;
  //
  //   if (array2.length == 0) {
  //     return false;
  //   }
  //   var findArray = [];
  //   for (var i = 0; i < array1.length; i++) {
  //     findArray =
  //         array2.where((prd) => prd['name'] == array1[i]['name']).toList();
  //     if (findArray.length > 0) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  getNbrForms() {
    var nbr = 0;
    print('option_chaux');
    print(product['option_chaux']);
    if (product['option_chaux'] != null &&
        product['option_chaux'].length > 0 &&
        optionC == null &&
        isValid == false) {
      nbr++;
    }
    print('option_froid');
    print(product['option_froid']);
    if (product['option_froid'] != null &&
        product['option_froid'].length > 0 &&
        optionF == null &&
        isValid == false) {
      nbr++;
    }
    print('option_sucre_sale');
    print(product['option_sucre_sale']);
    if (product['option_sucre_sale'] != null &&
        product['option_sucre_sale'].length > 0 &&
        optionS == null &&
        isValid == false) {
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.89,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  expandedHeight: 180.0,
                  centerTitle: true,
                  toolbarHeight: 60,
                  backgroundColor: Color(0xFFFF4C29),
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        product != null && product["productPicture"] != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 230,
                                color: Colors.white,
                                child: Image.network(
                                  baseurl +
                                      "public/products/" +
                                      product["productPicture"],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    title: Text(
                      product != null && product['name'] != null
                          ? product['name']
                          : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //leading: Icon(Icons.close, color: Colors.black,),
                ),
                SliverToBoxAdapter(
                  child: (getNbrForms() > 0)
                      ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFFF92D2F),
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
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product != null && product["name"] != null
                              ? product["name"]
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            height: 1.5,
                            fontFamily: 'JosefinSans',
                          ),
                        ),
                        Text(
                          product != null && product["price"] != null
                              ? product["price"].toString() + ' ' + 'TND'
                              : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            height: 1.5,
                            fontFamily: 'JosefinSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: (product['product_et'] != null &&
                              product['product_et'].length > 0)
                          ? ListView.builder(
                              itemCount: product['product_et'].length,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Text(
                                      product != null &&
                                              product['product_et'][index] !=
                                                  null &&
                                              product['product_et'][index]
                                                      ['nom_et'] !=
                                                  null
                                          ? product['product_et'][index]
                                              ['nom_et']
                                          : '',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                        product != null &&
                                                product['product_et'][index]
                                                        ['nom_et'] !=
                                                    null
                                            ? ', '
                                            : '',
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                );
                              })
                          : Container()),
                ),
                SliverToBoxAdapter(
                  child: (product['option_chaux'] != null &&
                          product['option_chaux'].length > 0)
                      ? Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Votre choix de café',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 20,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Choisir une option',
                                    style: TextStyle(
                                        color: (optionC == null &&
                                                isValid == false)
                                            ? Color(0xFFFF4C29)
                                            : Colors.black),
                                  ),
                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      color:
                                          (optionC == null && isValid == false)
                                              ? Color(0xFFFF4C29)
                                              : Colors.orange.shade50,
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 80,
                                      child: Text(
                                        'obligatoire',
                                        style: TextStyle(
                                          color: (optionC == null &&
                                                  isValid == false)
                                              ? Colors.white
                                              : Color(0xFFFF4C29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: (product['option_chaux'] != null &&
                          product['option_chaux'].length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: product['option_chaux'].length,
                          padding: EdgeInsets.all(0.0),
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int indexC) {
                            return Card(
                                shape: (optionC == null && isValid == false)
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : null,
                                elevation: 0.2,
                                child: RadioListTile(
                                  title: Text(product != null &&
                                          product['option_chaux'][indexC]
                                                  ['name'] !=
                                              null
                                      ? product['option_chaux'][indexC]['name']
                                      : ""),
                                  value: product['option_chaux'][indexC]
                                      .toString(),
                                  groupValue: myOptionC,
                                  onChanged: (value) {
                                    setState(() {
                                      myOptionC = value.toString();
                                      optionC = product['option_chaux'][indexC];
                                      // selectedItem.add(product['option_chaux'][indexC]);
                                    });
                                  },
                                  //selected: isSelectedC,
                                  activeColor: Colors.green,
                                  // toggleable: true,
                                ));
                          })
                      : Container(),
                )),
                SliverToBoxAdapter(
                  child: (product['option_froid'] != null &&
                          product['option_froid'].length > 0)
                      ? Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Votre choix de jus',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 20,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Choisir une option',
                                    style: TextStyle(
                                        color: (optionF == null &&
                                                isValid == false)
                                            ? Color(0xFFFF4C29)
                                            : Colors.black),
                                  ),
                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      color:
                                          (optionF == null && isValid == false)
                                              ? Color(0xFFFF4C29)
                                              : Colors.orange.shade50,
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 80,
                                      child: Text(
                                        'obligatoire',
                                        style: TextStyle(
                                          color: (optionF == null &&
                                                  isValid == false)
                                              ? Colors.white
                                              : Color(0xFFFF4C29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: (product['option_froid'] != null &&
                          product['option_froid'].length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: product['option_froid'].length,
                          padding: EdgeInsets.all(0.0),
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int indexF) {
                            return Card(
                              shape: (optionF == null && isValid == false)
                                  ? RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : null,
                              elevation: 0.2,
                              child: RadioListTile(
                                title: Text(product != null &&
                                        product['option_froid'][indexF]
                                                ['name'] !=
                                            null
                                    ? product['option_froid'][indexF]['name']
                                    : ""),
                                value: product['option_froid'][indexF]['name']
                                    .toString(),
                                groupValue: myOptionF,
                                onChanged: (value) {
                                  setState(() {
                                    // if(isSelectedF == false){
                                    //   isSelectedF = true;
                                    //   print('ddddddddddddddddd');
                                    //   print(isSelectedF);
                                    //   selectedItemF.add(product['option_froid'][indexF]);
                                    //   selectedItemF.removeWhere((value) => value!= product['option_froid'][indexF]);
                                    //   print('selectedItemffffffffffffff');
                                    //   print(selectedItemF);
                                    //   print(selectedItemF);
                                    //
                                    // } else {
                                    //   isSelectedF = false;
                                    //   print('fffffffffffffff');
                                    //   print(selectedItemF);
                                    //   selectedItemF.add(product['option_froid'][indexF]);
                                    //   selectedItemF.removeWhere((value) => value!= product['option_froid'][indexF]);
                                    //   print('selectedItemrrrrrrrrrrccccc');
                                    //   print(selectedItemF);
                                    //   selectedItem.addAll(selectedItemF);
                                    //   print(selectedItem);
                                    // }

                                    myOptionF = value.toString();
                                    optionF = product['option_froid'][indexF];
                                    // selectedItem.add(product['option_froid'][indexF]);
                                  });
                                },
                                // selected: isSelectedF,
                                activeColor: Colors.green,
                                // toggleable: true,
                              ),
                            );
                          })
                      : Container(),
                )),
                SliverToBoxAdapter(
                  child: (product['option_sucre_sale'] != null &&
                          product['option_sucre_sale'].length > 0)
                      ? Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Votre choix de crêpe',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 20,
                                    fontFamily: 'JosefinSans',
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Choisir une option',
                                    style: TextStyle(
                                        color: (optionS == null &&
                                                isValid == false)
                                            ? Color(0xFFFF4C29)
                                            : Colors.black),
                                  ),
                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      color:
                                          (optionS == null && isValid == false)
                                              ? Color(0xFFFF4C29)
                                              : Colors.orange.shade50,
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 80,
                                      child: Text(
                                        'obligatoire',
                                        style: TextStyle(
                                          color: (optionS == null &&
                                                  isValid == false)
                                              ? Colors.white
                                              : Color(0xFFFF4C29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: (product['option_sucre_sale'] != null &&
                          product['option_sucre_sale'].length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: product['option_sucre_sale'].length,
                          padding: EdgeInsets.all(0.0),
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int indexS) {
                            return Card(
                              shape: (optionS == null && isValid == false)
                                  ? RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : null,
                              elevation: 0.2,
                              child: RadioListTile(
                                title: Text(product != null &&
                                        product['option_sucre_sale'][indexS]
                                                ['name'] !=
                                            null
                                    ? product['option_sucre_sale'][indexS]
                                        ['name']
                                    : ""),
                                value: product['option_sucre_sale'][indexS]
                                        ['name']
                                    .toString(),
                                groupValue: myOptionS,
                                onChanged: (value) {
                                  setState(() {
                                    myOptionS = value.toString();
                                    optionS =
                                        product['option_sucre_sale'][indexS];
                                    // selectedItem.add(
                                    //     product['option_sucre_sale'][indexS]);
                                  });
                                  print("selectedItem[indexC]");
                                  print(selectedItem);
                                },
                                activeColor: Colors.green,
                              ),
                            );
                          })
                      : Container(),
                )),
              ],
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
                        color: Color(0xFF00C092),
                        size: 30,
                      ),
                    ),
                    width: 70,
                    padding: EdgeInsets.only(right: 5.0, left: 5.0),
                  ),
                  Container(
                    child: FlatButton(
                      height: 50,
                      onPressed: () {
                        var prd = product;
                        prd["quantity"] = quantity;
                        print("selectChoice");
                        if (optionC != null) {
                          selectedItem.add(optionC);
                        }
                        if (optionF != null) {
                          selectedItem.add(optionF);
                        }
                        if (optionS != null) {
                          selectedItem.add(optionS);
                        }

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
                                  '${product['price'] * quantity}' + ' DT',
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
    );
  }
}
