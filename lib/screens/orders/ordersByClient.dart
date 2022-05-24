import 'package:flutter/material.dart';
import 'package:scaneat/services/table_service.dart';
import 'package:intl/intl.dart';

class OrdersByClient extends StatefulWidget {
  String tableId;
  OrdersByClient(this.tableId);
  @override
  _OrdersByClientState createState() => _OrdersByClientState();
}

class _OrdersByClientState extends State<OrdersByClient>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final formatHours = new DateFormat('hh:mm');
  final formatDate = new DateFormat('dd/MM/yyyy');
  DateFormat formatter = DateFormat('dd/MM/yyyy à hh:mm');
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    print('_idtaaaaaaaaaaaaaaaaable');
    print(this.widget.tableId);
    refreshList();
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    _getTableByDetails();
  }
  var table = {};
  _getTableByDetails() async {
    print("ffffffffff");
    print(this.widget.tableId);
    var tableDetails = await TableService().getTableByOrders(this.widget.tableId);
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
  }
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        backgroundColor: Colors.orange.shade400,
        title: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Mes commandes',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: refreshKey,
          backgroundColor: Colors.orange.shade100,
          color: Colors.white,
          onRefresh: refreshList,
          child: ListView(
            padding: EdgeInsets.only(left: 20.0),
            children: <Widget>[
              TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xFFC88D67),
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 45.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  tabs: [
                    Tab(
                      child: Text('En cours',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    ),
                    Tab(
                      child: Text('Commandé',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    ),
                    Tab(
                      child: Text('commandes',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    )
                  ]),
              table!= null && table['orders']!= null ?Container(
                  height: MediaQuery.of(context).size.height - 50.0,
                  width: double.infinity,
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: table['orders'].length,
                                      itemBuilder: (BuildContext context, int index){
                                        return (table['orders'][index]['etat']== "En cours")?Card(
                                          child:  ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 14,
                                              child: Icon(Icons.blur_on_sharp, size: 20,color: Colors.yellow.shade400, ),
                                            ),
                                            title: Text(table!= null && table['orders'][index]['ref_cmd']!= null?table['orders'][index]['ref_cmd']:''),
                                            subtitle: Text(formatDate
                                                .format(DateTime.parse((table!= null && table['orders'][index]['date_commande']!= null?table['orders'][index]['date_commande']:'')))
                                                .toString()+
                                                " À " +formatHours
                                                .format(DateTime.parse(
                                                (table!= null && table['orders'][index]['date_commande']!= null?table['orders'][index]
                                                ['date_commande']:'')))
                                                .toString()),
                                            trailing: Text(table!= null && table['orders'][index]['prix']!= null?table['orders'][index]['prix'].toString():''+' TD'),

                                          ),
                                        ): Card();
                                      }),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: table['orders'].length,
                                    itemBuilder: (BuildContext context, int index){
                                      return (table['orders'][index]['etat']== "commandé")?Card(
                                        child:  ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 14,
                                            child: Icon(Icons.blur_on_sharp, size: 20, color: Colors.green,),
                                          ),
                                          title: Text(table!= null &&table['orders'][index]['ref_cmd']!= null?table['orders'][index]['ref_cmd']:''),
                                          subtitle: Text(formatDate
                                              .format(DateTime.parse((table!= null &&table['orders'][index]['date_commande']!= null?table['orders'][index]['date_commande']:'')))
                                              .toString()+
                                              " À " +formatHours
                                              .format(DateTime.parse(
                                              (table!= null &&table['orders'][index]['date_commande']!= null?table['orders'][index]
                                              ['date_commande']:'')))
                                              .toString()),
                                          trailing: Text(table!= null &&table['orders'][index]['prix']!= null?table['orders'][index]['prix'].toString():''+' TD'),

                                        ),
                                      ): Card();
                                    }),),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                        table['orders'].length,
                                        itemBuilder: (BuildContext context, int index){
                                          return  Card(
                                            child:  ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 14,
                                                child: (table['orders'][index]['etat']== "En cours")?
                                                Icon(Icons.blur_on_sharp, size: 20,color: Colors.yellowAccent.shade400):
                                                (table['orders'][index]['etat']== "commandé")?Icon(Icons.blur_on_sharp, size: 20, color: Colors.greenAccent.shade400):Icon(Icons.blur_on_sharp, size: 20),
                                              ),
                                              title: Text(table != null && table['orders'][index]['ref_cmd']!= null?table['orders'][index]['ref_cmd']:''),
                                              subtitle: Text(formatDate
                                                  .format(DateTime.parse((table != null && table['orders'][index]['date_commande']!= null?table['orders'][index]['date_commande']:'')))
                                                  .toString()+
                                                  " À " +formatHours
                                                  .format(DateTime.parse(
                                                  (table != null && table['orders'][index]['date_commande']!= null?table['orders'][index]['date_commande']:''))).toString()),
                                              trailing: Text(table != null && table['orders'][index]['prix']!= null?table['orders'][index]['prix'].toString():''+' TD'),
                                            ),
                                          );
                                        }),
                                  ),
                                ]
                            )
                        ),
                      ]
                  )
              ):Container()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.home),
        onPressed: () {
          print('helllo');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen =
                        //     Search(); // if user taps on this dashboard tab will be active
                        // currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.orange : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   currentScreen =
                      //       Chat(); // if user taps on this dashboard tab will be active
                      //   currentTab = 1;
                      // });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Caisse',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.orange : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   currentScreen =
                      //       Profile(); // if user taps on this dashboard tab will be active
                      //   currentTab = 2;
                      // });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   currentScreen =
                      //       Settings(); // if user taps on this dashboard tab will be active
                      //   currentTab = 3;
                      // });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {},
      //   backgroundColor: Color(0xFFF17532),
      //   child: Icon(Icons.fastfood),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //bottomNavigationBar: BottomBar(),
    );
  }
}
