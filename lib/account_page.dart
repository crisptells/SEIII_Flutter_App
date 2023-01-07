import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/storage_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'datattypes/datatypes.dart';

final makeListTile = ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  leading: Container(
    padding: const EdgeInsets.only(right: 12.0),
    decoration: const BoxDecoration(
        border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
    child: const Icon(Icons.school, color: Colors.white),
  ),
  title: const Text(
    "Kurs für Nachhilfe",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  subtitle: Row(
    children: const <Widget>[
      Icon(Icons.linear_scale, color: Colors.yellowAccent),
      Text(" Schwierigkeit: Normal", style: TextStyle(color: Colors.white))
    ],
  ),
  trailing:
      const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
);

final makeCard = Card(
  elevation: 8.0,
  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  child: Container(
    decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
    child: makeListTile,
  ),
);

const int itemCount = 20;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //Variable declaration
  String name = "";
  String vorName = "";
  var geld;

  //Calling the method to get user data
  @override
  void initState() {
    getUser();
  }

  //Method to retrieve user data
  getUser() async {
    var userEmail = "";
    //Use store manager to read logged in user
    //TODO fix: Storage manager braucht zu lange, deswegen hat userEmail keinen wert!
    StorageManager.readData('loggedInUser').then((value) async {
      print("value " + value);
      userEmail = value;
      Future.delayed(const Duration(seconds: 2), () => "someText");
    });
    print("userEmail " + userEmail);
    //Send Get User request to backend with email of logged in user
    String userEmailString = jsonEncode(<String, String>{"email": userEmail});
    print(userEmailString);
    Response response = await post(Uri.parse('http://127.0.0.1:3333/User'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': userEmailString}));
    if (response.statusCode == 200) {
      var responseJSON = json.decode(response.body);
      name = responseJSON['name'];
      vorName = responseJSON['firstname'];
      geld = responseJSON['cash'];
    } else {
      print('failed to retrieve user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    const double profileHeight = 144;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: profileHeight / 2,
              backgroundColor: Theme.of(context).backgroundColor,
              backgroundImage: const NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            name + vorName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "userEmail",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.all(20.0),
            child: Text(
              'Meine Kurse',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).iconTheme.color),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, index) {
              return makeCard;
            },
          ),
        ],
      ),
    );
  }
}
