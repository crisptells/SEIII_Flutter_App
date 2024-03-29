import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child: Icon(Icons.calculate_rounded,
              color: Theme.of(context).iconTheme.color!),
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child: Icon(Icons.book, color: Theme.of(context).iconTheme.color!),
        ),
        title: Text(
          "Deutsch",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.german.toString(),
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child: Icon(Icons.book, color: Theme.of(context).iconTheme.color!),
        ),
        title: Text(
          "Englisch",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.english.toString(),
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child: Icon(
            LineIcons.atom,
            color: Theme.of(context).iconTheme.color!,
          ),
        ),
        title: Text(
          "Physik",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.physics.toString(),
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child: Icon(
            LineIcons.flask,
            color: Theme.of(context).iconTheme.color!,
          ),
        ),
        title: Text(
          "Chemie",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.chemistry.toString(),
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
                      width: 1.0, color: Theme.of(context).disabledColor))),
          child:
              Icon(Icons.computer, color: Theme.of(context).iconTheme.color!),
        ),
        title: Text(
          "Informatik",
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          userExps.informatics.toString(),
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!,
              fontWeight: FontWeight.bold,
              fontSize: 20),
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
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;
    //Send request to backend
    print(userEmail);
    final response = await http.post(Uri.parse("http://127.0.0.1:3333/UserExp"),
        body: jsonEncode(<String, String>{
          "email": userEmail,
        }));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return UserExp.fromJson(body);
    } else {
      return UserExp(
          user_email: userEmail,
          math: 0,
          german: 0,
          english: 0,
          physics: 0,
          chemistry: 0,
          informatics: 0);
    }
  }

  static Future<List<Tutoring>> getUserTutorings() async {
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;

    final response = await http.post(
        Uri.parse("http://127.0.0.1:3333/GetUsersTutorings"),
        body: jsonEncode(<String, String>{"Email": userEmail}));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body.map<Tutoring>(Tutoring.fromJson).toList();
    } else {
      return List.empty();
    }
  }

  Future<User>? userFuture = getUser();
  //Method to retrieve user data
  static Future<User> getUser() async {
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;

    //Send Get User request to backend with email of logged in user
    final response = await post(Uri.parse('http://127.0.0.1:3333/User'),
        body: jsonEncode(<String, String>{"email": userEmail}));
    var body = json.decode(response.body);
    return User.fromJson(body);
  }

  Future<List<Tutoring>> tutoringsFuture = getUserTutorings();

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
                  return const Text(
                      "Benutzer hat noch keine Erfahrungspunkte gesammelt!");
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
            FutureBuilder<List<Tutoring>>(
              future: tutoringsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ahh error! ${snapshot.hasError}');
                } else if (snapshot.hasData) {
                  final tutorings = snapshot.data!;
                  return buildTutorings(tutorings);
                } else {
                  return const Text("no Tutorings data");
                }
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
            print(snapshot.data!.physics);
            return buildExp(snapshot.data!, context);
          } else {
            return const Text("no userExp data");
          }
        },
      ),
    ]);
  }
}

Widget buildTutorings(List<Tutoring> tutorings) => ListView.builder(
      shrinkWrap: true,
      itemCount: tutorings.length,
      itemBuilder: (context, index) {
        final tutoring = tutorings[index];
        return Card(
          child: ListTile(
            tileColor: Theme.of(context).backgroundColor,
            title: Text(
              tutoring.subject,
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            subtitle: Text(
              tutoring.tutor,
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            leading: Icon(
              Icons.school,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        );
      },
    );
