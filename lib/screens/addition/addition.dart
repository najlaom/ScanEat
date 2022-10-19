import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/services/table_service.dart';
import 'package:intl/intl.dart';

class Addition extends StatefulWidget{
  String tableId;
  Addition(this.tableId);
  @override
  State<Addition> createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  final formatHours = new DateFormat('hh:mm');
  final formatDate = new DateFormat('dd/MM/yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTableByIdFilter();
  }
  var table = {};
  _getTableByIdFilter() async {
    print("_fetchProducts");
    var productDetails =
    await TableService().getTableByDetails(this.widget.tableId.toString());
    print(productDetails.toString());
    if (productDetails.length > 0) {
      setState(() {
        table = productDetails;
      });
      print(table.toString());
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
        backgroundColor: Colors.orange.shade50,
        elevation: 0,
      ),
      body: Container(
        color: Colors.orange.shade50,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              table!= null && table['order']!= null?Container(
                width: 650,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft:
                      Radius.circular(16),
                      topRight:
                      Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                      EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        children: [
                          Text(
                            table!=null && table['manager_espace_client']!= null ?table['manager_espace_client']['logo']:'',
                            style: TextStyle(
                                color:
                                Colors.black,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                           table!=null && table['manager_espace_client']!= null ?table['manager_espace_client']['adresse']:'',
                            style: TextStyle(
                                color:
                                Colors.black,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            table!=null && table['manager_espace_client']!= null ?table['manager_espace_client']['num_tel']:'',
                            style: TextStyle(
                                color:
                                Colors.black,
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding:
                      EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                              formatDate
                                  .format(DateTime.parse(table !=
                                  null &&
                                  table['order']['date_commande'] !=
                                      null
                                  ? table['order']
                              [
                              'date_commande']
                                  : ''))
                                  .toString(),
                              style: TextStyle(
                                  color: Colors
                                      .black,
                                  fontSize:
                                  16.0)),
                          Text(
                              table != null &&
                                  table['order']
                                  [
                                  'ref_cmd'] !=
                                      null
                                  ? table['order']
                              ['ref_cmd']
                                  : '',
                              style: TextStyle(
                                  color: Colors
                                      .black,
                                  fontSize:
                                  20.0)),
                          Text(
                              formatHours
                                  .format(DateTime.parse(table !=
                                  null &&
                                  table['order']['date_commande'] !=
                                      null
                                  ? table['order']
                              [
                              'date_commande']
                                  : ''))
                                  .toString(),
                              style: TextStyle(
                                  color: Colors
                                      .black,
                                  fontSize:
                                  16.0)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          'Table : ${table['num_table']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0)),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: (table['order']['tableItems'].length >3)?250: 100,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                          table['order']['tableItems'].length,
                          itemBuilder:
                              (BuildContext context,
                              int index) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  '${table['order']['tableItems'][index]['quantity']}',
                                  style: TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  '${table['order']['tableItems'][index]['product']['name']}',
                                  style: TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  '${ table['order']['tableItems'][index]['price']} DT',
                                  style: TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 20.0),
                                )
                              ],
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Text(
                          '${table['order']['tableItems'].length} Pieces',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0)),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                  'total'.toUpperCase() +
                                      " DNT :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0)),
                              Text(
                                  '${table['order']['prix']}'+ ' DT',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0)),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Offre :', style: TextStyle(
                                  color: Colors.black,
                                  height: 1.5,
                                  fontSize: 20.0)),
                              Text('10%'),
                              Text('DNT')
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 450,
                      child: LayoutBuilder(builder:
                          (context, constraints) {
                        return Flex(
                          children: List.generate(
                              (constraints.constrainWidth() /
                                  10)
                                  .floor(),
                                  (index) => SizedBox(
                                height: 1,
                                width: 5,
                                child: DecoratedBox(
                                  decoration:
                                  BoxDecoration(
                                      color: Colors
                                          .grey
                                          .shade800),
                                ),
                              )),
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                        );
                      }),
                    ),
                    Container(
                      height: 60,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                            Radius.circular(16),
                            bottomRight:
                            Radius.circular(16)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: Text(
                            'merci et a bientot'
                                .toUpperCase()
                                .toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight:
                                FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ): Container(),
            ],
          ),
        ),
      )
    );
  }
}