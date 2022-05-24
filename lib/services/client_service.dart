import 'package:scaneat/services/url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class ClientService {

  Future getUsers() async {

    var url = baseurl + 'api/admin/users';
    print("urlllllllllllllll");
    print(url);
    var users = await http.post(Uri.parse(url));
    print("users");
    print(users.body);
    if (users.statusCode == 200) {
      print("categories.body");
      print(users.body);
      var jsonUsers = json.decode(users.body);
      print("aaaaaaaaaaaaaaaa");
      print(jsonUsers.toString());
      if (jsonUsers["success"] == true &&
          jsonUsers["result"].length > 0) {
        print(jsonUsers.toString());

        return jsonUsers["result"];
      } else
        return [];
    } else
      return [];
  }
}
