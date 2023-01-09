import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/http_getAllUsersTest.dart';
import 'package:flutter_test_app/http_insertNewUserTest.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/policy_page.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datattypes/datatypes.dart';
import 'learn_flutter_page.dart';

// ignore: must_be_immutable
class EnterPage extends StatefulWidget {
  String subject;
  String tutor;
  int tutoring_id;
  EnterPage(
      {super.key,
      required this.subject,
      required this.tutor,
      required this.tutoring_id});
  @override
  // ignore: no_logic_in_create_state
  State<EnterPage> createState() =>
      _EnterPageState(subject, tutor, tutoring_id);
}

class _EnterPageState extends State<EnterPage> {
  String subject;
  String tutor;
  int tutoring_id;
  _EnterPageState(this.subject, this.tutor, this.tutoring_id);
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
            Builder(builder: (context) {
              return Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => {
                      addUserTutoring(tutoring_id),
                      showActionSnackbar(context),
                    },
                    child: Text(
                      "Einschreiben",
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 16),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void showActionSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: const [
          Text(
            "Erfolgreich eingeschrieben! ",
            style: TextStyle(fontSize: 16),
          ),
          Icon(
            Icons.check,
            color: Colors.green,
          ),
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

  static addUserTutoring(int tutoring_id) async {
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
      print("adding user_tutoring worked: " + body);
    }
  }
}
