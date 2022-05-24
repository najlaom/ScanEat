import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/bloc/cart_items.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Categories extends StatefulWidget {
  String idCategory;
  String nameCategory;
  Categories(this.idCategory, this.nameCategory);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var numTable = '';
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkScannerTable();
    refreshList();
    bloc.initCart();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    _fetchCategories();
  }
  var categoryList = [];
  _fetchCategories() async {
    var categories = await CategoryService().getCategories();
    print(categories.toString());
    if (categories.length > 0) {
      setState(() {
        categoryList = categories;
      });

      // _fetchProductsByCategories();
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(categoryList.toString());
      // _fetchcatProducts();
    } else {
      setState(() {
        categoryList = [];
      });
    }
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.allItems,
        stream: bloc.getStream,
        builder: (context, snapshot) {
          return  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 80,
              backgroundColor: Color(0xFFFF4C29),
              title: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Table : ' + numTable,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0),
                  textAlign: TextAlign.start,
                ),
              ),
              elevation: 0,
              actions: <Widget>[
                Container(
                  width: 35,
                  child: Center(
                    child: Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddToTable()),
                            );
                          },
                        ),
                        bloc.allItems.length > 0
                            ? Positioned(
                          right: 15,
                          top: -3,
                          child: Container(
                              decoration: new BoxDecoration(
                                color: Color(0xFF2C394B),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Text(bloc.allItems.length.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white))),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
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
                  child:CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "Choisir une catégorie pour commander des plats en quelques secondes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                          ),
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Container(
                                  // padding: EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => Products(
                                                categoryList != null &&
                                                    categoryList[index]['_id'] != null
                                                    ? categoryList[index]['_id'].toString()
                                                    : '',
                                                categoryList != null &&
                                                    categoryList[index]['name'] != null
                                                    ? categoryList[index]['name'].toString()
                                                    : '')));
                                      },
                                      child: Card(
                                        elevation: 1.0,
                                        child: Column(
                                          children: [
                                            categoryList != null &&
                                                categoryList[index]['categoryImage'] !=
                                                    null
                                                ? Container(
                                              padding: EdgeInsets.all(10.0),
                                              width: 130,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(0),
                                                // border: Border.all(),
                                              ),
                                              child: Image.network(
                                                baseurl +
                                                    "public/categories/" +
                                                    categoryList[index]
                                                    ["categoryImage"],
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                                : Container(),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              // padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                categoryList != null &&
                                                    categoryList[index]['name'] != null
                                                    ? categoryList[index]["name"]
                                                    : '',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              }, childCount: categoryList.length),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
          );
        });
  }
}
