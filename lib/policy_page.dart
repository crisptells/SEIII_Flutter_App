import 'package:flutter/material.dart';
//import 'package:flutter_test_app/http_getAllUsersTest.dart';
//import 'package:flutter_test_app/http_insertNewUserTest.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';

//import 'learn_flutter_page.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
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
          'Impressum',
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
                'StudyRight',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Luis Maier, Christian Reitmeier',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Coblitzallee 1-9',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '68163 Mannheim',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Deutschland',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Kontakt',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Telefon: 0621 41050',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'E-Mail: luis.maier@gmx.de',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).iconTheme.color),
              ),
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
