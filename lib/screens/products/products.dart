import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/bloc/cart_items.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Products extends StatefulWidget {
  String idCategory;
  String nameCategory;
  Products(this.idCategory, this.nameCategory);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool loading = true;

  @override
  void initState() {
    refreshList();
    _loadData();
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    _fetchProductsByCategories();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  var productList = [];
  _fetchProductsByCategories() async {
    print("this.widget.idCategory");
    print(this.widget.idCategory);
    var products =
        await ProductService().getProductsByCategory(this.widget.idCategory);
    print(products.toString());
    if (products.length > 0) {
      setState(() {
        productList = products;
      });
      print("ppppppppppppppppppppppppppppppppppppppppppp");
      print(productList.toString());
      // _fetchcatProducts();
    } else {
      setState(() {
        productList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.allItems,
        stream: bloc.getStream,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 80,
                backgroundColor: Color(0xFFFF4C29),
                title: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    this.widget.nameCategory,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0),
                    textAlign: TextAlign.start,
                  ),
                ),
                elevation: 0,
              ),
              body: Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xFFFF4C29)),
                      height: 200,
                    ),
                  ),
                  RefreshIndicator(
                    key: refreshKey,
                    backgroundColor: Colors.white,
                    color: Color(0xFFFF4C29),
                    onRefresh: refreshList,
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Container(
                                    // padding: EdgeInsets.all(10.0),
                                    //color: Colors.black,
                                    height: 190,
                                    width: 350,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Detaills(
                                                productList != null &&
                                                        productList[index]
                                                                ['_id'] !=
                                                            null
                                                    ? productList[index]['_id']
                                                        .toString()
                                                    : ''),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 2.0,
                                        child: Column(
                                          //  mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            productList != null &&
                                                    productList[index][
                                                            "productPicture"] !=
                                                        null
                                                ? Container(
                                                    width: 160,
                                                    height: 120,
                                                    padding: EdgeInsets.only(top: 7.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      // border: Border.all(),
                                                    ),
                                                    child: Image.network(
                                                      baseurl +
                                                          "public/products/" +
                                                          productList[index][
                                                              "productPicture"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                productList[index]["name"] !=
                                                        null
                                                    ? productList[index]["name"]
                                                    : '',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              //padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                (productList[index]["price"]
                                                            .toString() !=
                                                        null)
                                                    ? productList[index]
                                                                ['price']
                                                            .toString() +
                                                        ' ' +
                                                        'TD'
                                                    : '',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  (bloc
                                              .getQuantityItemFromCart(
                                                  productList[index]['_id'])
                                              .toString()
                                              .length >
                                          0)
                                      ? Positioned(
                                          right: 15,
                                          top: -3,
                                          child: bloc.getQuantityItemFromCart(
                                                      productList[index]
                                                          ['_id']) !=
                                                  null
                                              ? Container(
                                                  decoration: new BoxDecoration(
                                                    color:
                                                    Color(0xFFFF4C29),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                      bloc
                                                          .getQuantityItemFromCart(
                                                              productList[index]
                                                                  ['_id'])
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white)))
                                              : Container(),
                                        )
                                      : Container()
                                ],
                              );
                            }, childCount: productList.length),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                      child: (bloc.allItems.length) >= 1
                          ? Card(
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddToTable()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            //alignment: Alignment.center,
                            color: Colors.green,
                            //padding: EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    (bloc.allItems.length) == 1
                                        ? '${bloc.allItems.length.toString()} Produit'
                                        : '${bloc.allItems.length.toString()} Produits',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                        fontSize: 14,
                                        fontFamily: 'JosefinSans')),
                                Text('Voir Commande',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        fontSize: 18,
                                        fontFamily: 'JosefinSans')),
                                Text(
                                  '${bloc.getTotalItemFromCart()} DT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                      fontSize: 14,
                                      fontFamily: 'JosefinSans'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                          : Card(),
                    )
                  ),
                ],
              ));
        });
  }
}
