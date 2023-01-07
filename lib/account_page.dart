import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/storage_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
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

//User information
Widget userInfo(User user, BuildContext context) {
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        "${user.firstName} ${user.name}",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).iconTheme.color),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        user.email,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).iconTheme.color),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

//Stuff for Exp
Widget buildExp(UserExp userExps, BuildContext context) {
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: <Widget>[
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      width: 1.0, color: Theme.of(context).iconTheme.color!))),
          child: const Icon(Icons.calculate_rounded, color: Colors.white),
        ),
        title: Text(
          "Mathe",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.math.toString(),
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      width: 1.0, color: Theme.of(context).disabledColor!))),
          child: const Icon(Icons.book, color: Colors.white),
        ),
        title: const Text(
          "Deutsch",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Text(
          userExps.german.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.book, color: Colors.white),
        ),
        title: const Text(
          "Englisch",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Text(
          userExps.english.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(LineIcons.atom),
        ),
        title: const Text(
          "Physik",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Text(
          userExps.physics.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(LineIcons.flask),
        ),
        title: const Text(
          "Chemie",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Text(
          userExps.chemistry.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.computer, color: Colors.white),
        ),
        title: const Text(
          "Informatik",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Text(
          userExps.informatics.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ],
  );
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //Variable declaration
  String name = "";
  String vorName = "";
  String userEmail = "";
  var geld;

  Future<UserExp> userExpesFuture = getUserExp();
  //Muss hieraus post machen und wieder user email mitgeben
  static Future<UserExp> getUserExp() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:3333/Experiences"));

    final body = json.decode(response.body);
    var resultList = body.map<UserExp>(UserExp.fromJson).toList();
    return resultList[0];
  }

  Future<User> userFuture = getUser();
  //Method to retrieve user data
  static Future<User> getUser() async {
    String userEmail = "";

    //Use store manager to read logged in user
    StorageManager.readData('loggedInUser').then((value) {
      userEmail = value;
    });

    //Send Get User request to backend with email of logged in user
    Response response = await post(Uri.parse('http://127.0.0.1:3333/User'),
        body: jsonEncode(<String, String>{"email": "luis.maier@gmx.de2"}));

    var body = json.decode(response.body);
    return User.fromJson(body);
  }

  @override
  Widget build(BuildContext context) {
    const double profileHeight = 144;

    return ListView(children: [
      SingleChildScrollView(
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
            FutureBuilder<User>(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ahh error! ${snapshot.hasError}');
                } else if (snapshot.hasData) {
                  return userInfo(snapshot.data!, context);
                } else {
                  return const Text("no userExp data");
                }
              },
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
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(20.0),
        child: Text(
          'Meine Erfahrungspunkte',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).iconTheme.color),
        ),
      ),
      FutureBuilder<UserExp>(
        future: userExpesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Ahh error! ${snapshot.hasError}');
          } else if (snapshot.hasData) {
            return buildExp(snapshot.data!, context);
          } else {
            return const Text("no userExp data");
          }
        },
      ),
    ]);
  }
}
