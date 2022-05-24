import 'package:flutter/material.dart';
import 'package:scaneat/screens/livraison/home_caffe.dart';

class Settings2 extends StatelessWidget {
  static final String path = "lib/src/pages/settings/profilesettings.dart";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditPage(),
    );
  }
}

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool showPassword = false;
  final Color active = Colors.black;
  final Color divider = Colors.grey.shade400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.orange.shade400,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Compte',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your account details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Editer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.orangeAccent.shade200),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              buildTextField("Full Name", "Evan kutto", false),
              buildTextField("E-mail", "evan@gmail.com", false),
              buildTextField("Password", "********", true),
              buildTextField("Location", "New Joursey", false),
              buildTextField("Numéro de téléphone", "+216 23129292", false),


            ],
          ),
        ),
      ),
    );
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
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
