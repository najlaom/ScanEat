import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/res/colors.dart';
import 'package:scaneat/screens/livraison/categories_livraison.dart';
import 'package:scaneat/services/client_service.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:scaneat/utils/helper.dart';
import 'package:scaneat/widgets/searchBar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;

class HomeCoffee extends StatefulWidget {
  @override
  State<HomeCoffee> createState() => _HomeCoffeeState();
}

class _HomeCoffeeState extends State<HomeCoffee> {
  final _formKey = GlobalKey<FormState>();
  final Color primary = Colors.white;
  final Color active = Colors.black;
  final Color divider = Colors.grey.shade400;
  @override
  void initState() {
    _fetchUsers();
    super.initState();
  }
  var userList = [];

  _fetchUsers() async {
    var users = await ClientService().getUsers();
    print(users.toString());
    if (users.length > 0) {
      setState(() {
        userList = users;
      });

      // _fetchProductsByCategories();
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(userList.toString());
      // _fetchcatProducts();
    } else {
      setState(() {
        userList = [];
      });
    }
  }
  final name = 'Sarah Abs';
  final email = 'sarah@abs.com';
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          backgroundColor: Colors.orange.shade400,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.expand_more_outlined,
                  color: Colors.white,
                )),
          ],
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Livraison à',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "36 Rue de l'energie",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ),
        drawer: _buildDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: SearchBar(
                      "Search Food",
                    ),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Most Popular",
                              style: Helper.getTheme(context).headline5,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("View all"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoriesLivraison(),
                            ),
                          );
                        },
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: userList.length,
                              itemBuilder: (context, index){
                                return userList[index]['role']== 'Espace Client'?Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: MostPopularCard(
                                    image: Image.network(
                                      baseurl +
                                          "public/LogoClub/" +
                                          userList[index]["LogoImage"],
                                      fit: BoxFit.cover,
                                    ),
                                    name: userList[index]['lastName'],
                                  ),
                                ):Container();
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tous les vendeurs",
                              style: Helper.getTheme(context).headline5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RestaurantCard(
                        image: Image.asset(
                          Helper.getAssetName("pizza2.jpg", "real"),
                          fit: BoxFit.cover,
                        ),
                        name: "Minute by tuk tuk",
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RestaurantCard(
                        image: Image.asset(
                          Helper.getAssetName("pizza2.jpg", "real"),
                          fit: BoxFit.cover,
                        ),
                        name: "Minute by tuk tuk",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Items",
                              style: Helper.getTheme(context).headline5,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("View all"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context)
                                //     .pushNamed(IndividualItem.routeName);
                              },
                              child: RecentItemCard(
                                image: Image.asset(
                                  Helper.getAssetName("pizza3.jpg", "real"),
                                  fit: BoxFit.cover,
                                ),
                                name: "Mulberry Pizza by Josh",
                              ),
                            ),
                            RecentItemCard(
                                image: Image.asset(
                                  Helper.getAssetName("coffee.jpg", "real"),
                                  fit: BoxFit.cover,
                                ),
                                name: "Barita"),
                            RecentItemCard(
                                image: Image.asset(
                                  Helper.getAssetName("pizza.jpg", "real"),
                                  fit: BoxFit.cover,
                                ),
                                name: "Pizza Rush Hour"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _buildDrawer() {
    return Drawer(
      child: Material(
        child: ListView(
          children: [
            Container(
              color: Colors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.0),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Najla Omrani',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("najla.omrani@esprit.tn",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            _buildRow(Icons.location_on_outlined , "Emplacement"),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeCoffee(),),);
              },
              child:   _buildRow(Icons.local_restaurant , "Restaurants"),
            ),
            SizedBox(height: 10.0),
            _buildRow(Icons.account_circle_outlined , "Compte"),
            SizedBox(height: 10.0),
            _buildRow(Icons.coffee, "Commandes"),
            _buildDivider(),
            SizedBox(height: 20.0),
            _buildRow2('Configuration'),
            SizedBox(height: 10.0),
            _buildRow2('Information'),
            SizedBox(height: 10.0),
            _buildRow2('Déconnexion'),
          ],
        )
      ),
    );
  }
  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.black54,
          size: 30,
        ),
        SizedBox(width: 30.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }
  Widget _buildRow2(String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(children: [
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }

}

class RecentItemCard extends StatelessWidget {
  const RecentItemCard({
    Key? key,
    required String name,
    required Image image,
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 80,
            height: 80,
            child: _image,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                ),
                Row(
                  children: [
                    Text("Cafe"),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Western Food"),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      Helper.getAssetName("star_filled.png", "virtual"),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "4.9",
                      style: TextStyle(
                        color: AppColor.orange,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('(124) Ratings')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoriesLivraison(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoriesLivraison(),
        ));
        break;
    }
  }
}

class MostPopularCard extends StatelessWidget {
  const MostPopularCard({
    Key? key,
    required String name,
    required Image image,
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final Image _image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 300,
            height: 200,
            child: _image,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          _name,
        ),
        Row(
          children: [
            Text("Cafe"),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                ".",
                style: TextStyle(
                  color: AppColor.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Western Food"),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              Helper.getAssetName("star_filled.png", "virtual"),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "4.9",
              style: TextStyle(
                color: AppColor.orange,
              ),
            )
          ],
        )
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required String name,
    required Image image,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String _name;
  final Image _image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      width: double.infinity,
      child: Card(
        elevation: 2.0,
        child: Column(
          children: [
            SizedBox(height: 200, width: double.infinity, child: _image),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        _name,
                        style: Helper.getTheme(context).headline5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Helper.getAssetName("star_filled.png", "virtual"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.9",
                        style: TextStyle(
                          color: AppColor.orange,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("(124 ratings)"),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Cafe"),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          ".",
                          style: TextStyle(
                            color: AppColor.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Western Food"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required Image image,
    required String name,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 100,
            height: 100,
            child: _image,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          _name,
        ),
      ],
    );
  }
}
