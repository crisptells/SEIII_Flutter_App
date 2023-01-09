import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter_test_app/http_getAllUsersTest.dart';
//import 'package:flutter_test_app/http_insertNewUserTest.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/policy_page.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'datattypes/datatypes.dart';

// ignore: must_be_immutable
class EnterPage extends StatefulWidget {
  String subject;
  String tutor;
  int tutoring_id;
  String description;
  EnterPage(
      {super.key,
      required this.subject,
      required this.tutor,
      required this.tutoring_id,
      required this.description});
  @override
  // ignore: no_logic_in_create_state
  State<EnterPage> createState() =>
      _EnterPageState(subject, tutor, tutoring_id, description);
}

class _EnterPageState extends State<EnterPage> {
  String subject;
  String tutor;
  int tutoring_id;
  String description;
  _EnterPageState(this.subject, this.tutor, this.tutoring_id, this.description);
  bool isSwitch = false;
  bool? isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Einschreiben',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        automaticallyImplyLeading:
            false, // automatischer Back Button aus der App Bar weg (bei false)
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          Theme(
            data: Theme.of(context)
                .copyWith(dividerColor: Theme.of(context).hintColor),
            child: PopupMenuButton<int>(
              color: Theme.of(context).backgroundColor,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.settings,
                          color: Theme.of(context).iconTheme.color),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Einstellungen',
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.policy,
                          color: Theme.of(context).iconTheme.color),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Impressum',
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Login/Logout',
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Checkbox(
                          value: themeChange.darkTheme,
                          onChanged: (value) {
                            themeChange.darkTheme = value!;
                          }),
                    ],
                  ),
                ),
              ],
              onSelected: (item) => SelectedItem(context, item),
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20.0),
              child: Text(
                'Kursübersicht',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Fach: $subject',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Dozent: $tutor',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Beschreibung: $description',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).backgroundColor,
                      backgroundColor: Theme.of(context).iconTheme.color,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      addUserTutoring(tutoring_id);
                    },
                    child: const Text('Einschreiben'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(
                      future: showEndTutoringButton(context, tutor),
                      builder: (BuildContext context, snapshot) {
                        bool tutorLoggedIn = false;
                        if (snapshot.hasData) {
                          tutorLoggedIn = snapshot.data!;
                        }
                        if (tutorLoggedIn == true) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).backgroundColor,
                              backgroundColor:
                                  Theme.of(context).iconTheme.color,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              finishLesson(tutoring_id, subject);
                            },
                            child: const Text('Kurs beenden'),
                          );
                        } else {
                          return Container();
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showActionSnackbar(BuildContext context, String content, bool check) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
          check
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.clear,
                  color: Colors.red[700],
                )
        ],
      ),
      action: SnackBarAction(
        label: " ",
        onPressed: () {
          print("SnackBar Action");
        },
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> showEndTutoringButton(BuildContext context, String name) async {
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;

    final response = await http.post(Uri.parse('http://127.0.0.1:3333/User'),
        body: jsonEncode(<String, String>{"email": userEmail}));
    User user;
    if (response.statusCode != 200) {
      return false;
    }
    var body = json.decode(response.body);
    user = User.fromJson(body);

    if (user.name == name) {
      return true;
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  SelectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PolicyPage()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                LoginPage())); // wenn richtige Login Seite da ist dann pushAndRemoveUntil
        break;
    }
  }

  addUserTutoring(int tutoring_id) async {
    //Use store manager to read logged in user
    var prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('loggedInUser')!;

    final response = await http.post(
        Uri.parse("http://127.0.0.1:3333/AddUserTutoring"),
        body: jsonEncode(<String, String>{
          "user_email": userEmail,
          "tutoring_id": tutoring_id.toString()
        }));
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      showActionSnackbar(context, "Erfolgreich eingeschrieben", true);
    } else if (response.statusCode == 401) {
      showActionSnackbar(context, "Bereits eingeschrieben", false);
    } else {
      showActionSnackbar(context, "Irgendwas ist schiefgelaufe :(", false);
    }
  }

  finishLesson(int tutoring_id, String subject) async {
    final response = await http.post(
        Uri.parse("http://127.0.0.1:3333/GetTutoringsUsers"),
        body: jsonEncode(
            <String, String>{"tutoring_id": tutoring_id.toString()}));
    final usersList = json.decode(response.body);
    var body;

    print(tutoring_id);
    for (String u in usersList) {
      switch (subject) {
        case "Mathe":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 5,
              "german": 0,
              "english": 0,
              "physics": 0,
              "chemistry": 0,
              "informatics": 0
            });
          }
          break;
        case "Deutsch":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 0,
              "german": 5,
              "english": 0,
              "physics": 0,
              "chemistry": 0,
              "informatics": 0
            });
          }
          break;
        case "Englisch":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 0,
              "german": 0,
              "english": 5,
              "physics": 0,
              "chemistry": 0,
              "informatics": 0
            });
          }
          break;
        case "Physik":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 0,
              "german": 0,
              "english": 0,
              "physics": 5,
              "chemistry": 0,
              "informatics": 0
            });
          }
          break;
        case "Chemie":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 0,
              "german": 0,
              "english": 0,
              "physics": 0,
              "chemistry": 5,
              "informatics": 0
            });
          }
          break;
        case "Informatik":
          {
            body = jsonEncode(<String, dynamic>{
              "user_email": u,
              "math": 0,
              "german": 0,
              "english": 0,
              "physics": 0,
              "chemistry": 0,
              "informatics": 5
            });
          }
          break;
      }

      final response2 = await http
          .post(Uri.parse("http://127.0.0.1:3333/CountUpExp"), body: body);
      final body2 = json.decode(response2.body);
      if (response2.statusCode == 200) {
        showActionSnackbar(context, "Erfolgreich abgeschlossen", true);
      } else {
        showActionSnackbar(context, "Irgendwas ist schiefgelaufe :(", false);
      }
    }
  }
}
