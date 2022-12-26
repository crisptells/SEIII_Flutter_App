import 'package:flutter/material.dart';
import 'package:flutter_test_app/http_getAllUsersTest.dart';
import 'package:flutter_test_app/http_insertNewUserTest.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/policy_page.dart';

import 'learn_flutter_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitch = false;
  bool? isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Einstellungen',
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
                .copyWith(dividerColor: Theme.of(context).iconTheme.color),
            child: PopupMenuButton<int>(
              color: Theme.of(context).iconTheme.color,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.white),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.policy, color: Colors.white),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Policy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              onSelected: (item) => SelectedItem(context, item),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
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
            const Divider(
              color: Colors.white,
            ),
            Container(),
          ],
        ),
      ),
    );
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
                const LoginPage())); // wenn richtige Login Seite da ist dann pushAndRemoveUntil
        break;
    }
  }
}
