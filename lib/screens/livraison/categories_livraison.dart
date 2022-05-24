import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/products/products.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/bloc/cart_items.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesLivraison extends StatefulWidget {
  @override
  _CategoriesLivraisonState createState() => _CategoriesLivraisonState();
}

class _CategoriesLivraisonState extends State<CategoriesLivraison> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int currentpage = 0;
  GlobalKey buttomNavigationkey = GlobalKey();
  late SharedPreferences sharedPreferences;
  List tableContent = [];
  var numTable ='';
  @override
  void initState() {
    refreshList();
    tableContent = bloc.allItems;
    calculTotal();
    bloc.initCart();
    _checkScannerTable();
    super.initState();
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    _fetchCategories();
  }
  _checkScannerTable() async {
    var tableDetails = await TableService().getTableInfos();
    print("tableDetailsssss");
    print(tableDetails);
    if (tableDetails.isNotEmpty &&
        tableDetails["tableid"] != null &&  tableDetails["numTable"] != null) {
      print('tableid');
      print(tableDetails["tableid"]);
      numTable = tableDetails["numTable"];
      print("numTable");
      print(numTable);
    }
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

  double total = 0;
  bool loading = true;
  final storage = new FlutterSecureStorage();
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
              backgroundColor: Colors.orange.shade400,
              leading: IconButton(
                icon: Icon(Icons.close, color: Color(0xFF545D68)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('BienVenue '  ,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            body: RefreshIndicator(
              key: refreshKey,
              backgroundColor: Colors.orange.shade100,
              color: Colors.white,
              onRefresh: refreshList,
              child: CustomScrollView(
                slivers: <Widget>[
                  //   _buildAppBar(context),
                  _buildListProduct(),
                ],
              ),
            ),
          );
        });
  }

  SliverGrid _buildListProduct() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
            // padding: EdgeInsets.all(5.0),
            child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Products(
                    categoryList != null && categoryList[index]['_id'] != null
                        ? categoryList[index]['_id'].toString()
                        : '',
                    categoryList != null && categoryList[index]['name'] != null
                        ? categoryList[index]['name'].toString()
                        : '')));
          },
          child: Card(
            elevation: 1.0,
            child: Column(
              children: [
                categoryList != null && categoryList[index]['categoryImage'] != null
                    ?Container(
                  padding: EdgeInsets.all(10.0),
                  height: 90,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    // border: Border.all(),
                  ),
                  child: Image.network(
                    baseurl +
                        "public/categories/" +
                        categoryList[index]["categoryImage"],
                    fit: BoxFit.cover,
                  ),
                ):Container(),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.all(5.0),
                  child: Text(
                    categoryList != null && categoryList[index]['name'] != null
                        ?categoryList[index]["name"]:'',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));
      }, childCount: categoryList.length),
    );
  }
}
