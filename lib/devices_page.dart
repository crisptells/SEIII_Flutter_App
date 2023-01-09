import 'package:flutter/material.dart';
import 'package:flutter_test_app/account_page.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/policy_page.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  bool isSwitch = false;
  bool? isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool isChecked = false;
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
              child: Text(
                'Geräte',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    "Web",
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.computer,
                    color: Theme.of(context).iconTheme.color,
                    size: 60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).iconTheme.color,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    "iOS",
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.apple,
                    color: Theme.of(context).iconTheme.color,
                    size: 60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).iconTheme.color,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    "Android",
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.android,
                    color: Theme.of(context).iconTheme.color,
                    size: 60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
