import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class ScanQRcode extends StatefulWidget {
  @override
  _ScanQRcodeState createState() => _ScanQRcodeState();
}

class _ScanQRcodeState extends State<ScanQRcode> {
  final controller = TextEditingController();

  Future scanbarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#009922", "CANCEL", true, ScanMode.DEFAULT)
        .then((idTable) async {
      print("idPrddddddddddd : ");
      var table = {};
      var tableDetails = await TableService().getTable(idTable);
      print("tableDetails");
      print(tableDetails);
      if (tableDetails.length > 0) {
        setState(() {
          table = tableDetails;
        });
        print('table');
        print(table);
      } else {
        setState(() {
          table = {};
        });
      }
      if (table['_type_order'] == "Non Ajouter") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BienVenue(idTable),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Order(idTable),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xFFFF4C29),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              alignment: Alignment.topCenter,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFFF4C29),
              ),
              child: Image.asset(
                'assets/images/logo.png',
                height: 130,
                width: 130,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: () {
                    scanbarcode();
                  },
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/qrcode.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text("Scan, Choose, Eat!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF082032),
                        fontWeight: FontWeight.w800)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
