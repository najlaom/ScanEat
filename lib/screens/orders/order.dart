import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/table_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Order extends StatefulWidget {
  final String idTable;
  Order(this.idTable);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formatHours = new DateFormat('hh:mm');
  final formatDate = new DateFormat('dd/MM/yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTableByDetails();
  }

  var table = {};
  _getTableByDetails() async {
    print("ffffffffff");
    print(this.widget.idTable);
    var tableDetails =
        await TableService().getTableByOrder(this.widget.idTable);
    print("tableDetailsofffffffffffffffffffffffffffffffffffffffff");
    print(tableDetails);
    if (tableDetails.length > 0) {
      setState(() {
        table = tableDetails;
      });
      print('tableoffffffffffffff');
      print(table);
    } else {
      setState(() {
        table = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xFFFF4C29),
        title: Text(
          table != null && table['num_table'] != null ? table['num_table'] : '',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
          textAlign: TextAlign.start,
        ),
        elevation: 0,
      ),
      body: table != null && table['order'] != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(color: Color(0xFFFF4C29)),
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                formatDate
                                    .format(DateTime.parse(table != null &&
                                            table['order']['date_commande'] !=
                                                null
                                        ? table['order']['date_commande']
                                        : ''))
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              ),
                            ),
                            Text(
                                formatHours
                                    .format(DateTime.parse(table != null &&
                                            table['order']['date_commande'] !=
                                                null
                                        ? table['order']['date_commande']
                                        : ''))
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0)),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              child: Text(
                                table != null && table['order']['etat'] != null
                                    ? table['order']['etat'].toString()
                                    : '',
                                style: TextStyle(
                                    color: Color(0xFF082032), fontSize: 20),
                              ),
                            )
                          ],
                        )),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(top: 60, left: 16.0, right: 16.0),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            child: Container(
                                height: 550,
                                child:
                                    table != null &&
                                            table['order']['tableItems'] != null
                                        ? ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: table['order']
                                                    ['tableItems']
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Card(
                                                  child: Container(
                                                height: 70,
                                                color:
                                                    table['order']['tableItems']
                                                                    [index][
                                                                'etat_payed'] ==
                                                            'Payed'
                                                        ? Colors.green.shade100
                                                        : Colors.yellow.shade50,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text((table !=
                                                                            null &&
                                                                        table['order']['tableItems'][index]['quantity'] !=
                                                                            null
                                                                    ? table['order']['tableItems'][index]
                                                                            [
                                                                            'quantity']
                                                                        .toString()
                                                                    : "")),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Color(
                                                                      0xFF082032),
                                                                  size: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(table !=
                                                                            null &&
                                                                        table['order']['tableItems'][index]['product']['name'] !=
                                                                            null
                                                                    ? table['order']['tableItems']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'product']['name']
                                                                    : ""),
                                                                SizedBox(
                                                                  width: 30,
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text('Prix : ' +
                                                                  (table != null &&
                                                                          table['order']['tableItems'][index]['price'] !=
                                                                              null
                                                                      ? table['order']['tableItems'][index]
                                                                              [
                                                                              'price']
                                                                          .toString()
                                                                      : "")),
                                                            )
                                                          ],
                                                        )),
                                                    Expanded(
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: table['order']
                                                                          [
                                                                          'tableItems']
                                                                      [index][
                                                                  'selectChoice']
                                                              .length,
                                                          itemBuilder: (BuildContext
                                                                  context,
                                                              int indexChoise) {
                                                            return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  table['order']['tableItems'][index]
                                                                              [
                                                                              'selectChoice']
                                                                          [
                                                                          indexChoise] +
                                                                      ', ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.0),
                                                                ));
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                            })
                                        : Container()),
                          ),
                          Card(
                            elevation: 0.0,
                            child: Container(
                              alignment: Alignment.center,
                              width: 380,
                              height: 50,
                              child: Text(
                                  'Total : ' +
                                      (table != null &&
                                              table['order']['prix'] != null
                                          ? table['order']['prix'].toString()
                                          : '') +
                                      ' DT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      bottom: 5.0,
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Addition(this.widget.idTable),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 199,
                                  height: MediaQuery.of(context).size.height,
                                  color: Color(0xFF00C092),
                                  child: Text('Addition',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('iddddddddddddddddddddddddddddddd');
                                  print(table['num_table']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Categories(
                                          this.widget.idTable,
                                          table != null &&
                                                  table['num_table'] != null
                                              ? table['num_table']
                                              : ''),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  color: Color(0xFFFED440),
                                  child: Text('Ajouter autre commande',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          : Container(),
    );
  }
}
