import 'package:flutter/material.dart';
import 'package:scaneat/screens/scrren.dart';
import 'package:scaneat/services/url_service.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class BienVenue extends StatefulWidget {
  final String tableId;
  BienVenue(this.tableId);
  @override
  State<BienVenue> createState() => _BienVenueState();
}

class _BienVenueState extends State<BienVenue> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTableByDetails();
  }

  var table = {};
  _getTableByDetails() async {
    print("ffffffffff");
    print(this.widget.tableId);
    var tableDetails =
        await TableService().getTableByDetails(this.widget.tableId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xFFFF4C29),
        title: Text(
          table!=null && table['manager_espace_client']!= null ?table['manager_espace_client']['logo']:'',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
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
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 16.0, right: 16.0),
              child: Card(
                elevation: 2,
                child: Container(
                  height: 500,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "Bienvenue",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF082032),
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: table != null && table['server']!= null && table['server']['profilePicture']!=null?Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      baseurl +
                                          "public/employes/"+table['server']['profilePicture']
                                  ),),),
                        ):Container(),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: table['state'] == 'Affecter'?Text(
                          'Vous serez servi par ' + (table != null && table['server'] != null &&table['server']['firstName'] != null ?'Haifa':''),
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ): null,
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: table['state'] == 'Affecter'?Text(
                          'à la table : ' + table['num_table'],
                          style: Theme.of(context).textTheme.headline6,
                        ): Text('Table : ${table['num_table']}', style: Theme.of(context).textTheme.headline6,),
                      ),
                      const SizedBox(height: 60.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Categories(
                                  table != null &&
                                      table['_id'] != null
                                      ? table['_id']
                                      : '',
                                  table != null &&
                                      table['num_table'] != null
                                      ? table['num_table']
                                      : ''),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          width: 160,
                          child: Card(
                            elevation: 1,
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(0xFF082032),
                              child: Text(
                                'entrer'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
