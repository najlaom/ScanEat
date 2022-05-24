import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/scrren.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 4);
    Future.delayed(d, (){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScanQRcode()), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFFF4C29)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 5.0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.cyan.shade50,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          ],
        )
      ),
    );
  }
}