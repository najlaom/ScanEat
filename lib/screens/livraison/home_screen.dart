import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/livraison/home_caffe.dart';
import 'package:scaneat/utils/helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          backgroundColor: Colors.orange.shade400,
          leading: IconButton(
            icon: Icon(Icons.close, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5.0),
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
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeCoffee(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                height: 100,
                width: 405,
                child: Card(
                    elevation: 2,
                    child: Container(
                      // alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              Helper.getAssetName('coffee.png', 'virtual'),
                              height: 80,
                              width: 60,
                            ),
                          ),
                          Container(
                              width: 280,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Caffé',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20.0),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text('Vos plats préférés prés de chez vous',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.0),
                                      textAlign: TextAlign.start),
                                ],
                              )),
                          Container(
                            width: 30,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 5.0),
              height: 100,
              width: 405,
              child: Card(
                  elevation: 2,
                  child: Container(
                    // alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            Helper.getAssetName('restaurant.png', 'virtual'),
                            height: 80,
                            width: 60,
                          ),
                        ),
                        Container(
                            width: 280,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Restaurant',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('Vos plats préférés prés de chez vous',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    textAlign: TextAlign.start),
                              ],
                            )),
                        Container(
                          width: 30,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 5.0),
              height: 100,
              width: 405,
              child: Card(
                  elevation: 2,
                  child: Container(
                    // alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            Helper.getAssetName('gourmandise.png', 'virtual'),
                            height: 80,
                            width: 60,
                          ),
                        ),
                        Container(
                            width: 280,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gourmandise',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('Vos plats préférés prés de chez vous',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    textAlign: TextAlign.start),
                              ],
                            )),
                        Container(
                          width: 30,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 5.0),
              height: 100,
              width: 405,
              child: Card(
                  elevation: 2,
                  child: Container(
                    // alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            Helper.getAssetName('boulangerie.png', 'virtual'),
                            height: 80,
                            width: 60,
                          ),
                        ),
                        Container(
                            width: 280,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Boulangerie & Patisserie',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('Vos plats préférés prés de chez vous',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    textAlign: TextAlign.start),
                              ],
                            )),
                        Container(
                          width: 30,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
