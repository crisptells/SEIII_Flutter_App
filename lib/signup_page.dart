import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/login_out_page.dart';
import 'package:flutter_test_app/policy_page.dart';
import 'package:flutter_test_app/services/storage_manager.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();

  void signup(String email, password, name, firstname) async {
    try {
      Response response = await post(Uri.parse('http://127.0.0.1:3333/AddUser'),
          body: jsonEncode(<String, String>{
            "email": email,
            "password": password,
            "name": name,
            "firstName": firstname,
            "cash": "0"
          }));
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data);
        StorageManager.saveData('loggedInUser', email);
        print('SignUp successfully, now logged in');
        Navigator.pop(context);
        StorageManager.readData('loggedInUser').then((value) {
          print('user read from storage: $value');
        });
      } else {
        print('failed to SignUp');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool isSwitch = false;
  bool? isCheckBox = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Registrieren',
          style:
              TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 26),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Theme(
            data: Theme.of(context)
                .copyWith(dividerColor: Theme.of(context).hintColor),
            child: PopupMenuButton<int>(
              color: Theme.of(context).primaryColor,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), //Abstandshalter
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Theme.of(context).iconTheme.color)),
            ),
            const SizedBox(height: 20), //Abstandshalter
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                  labelText: 'Vorname',
                  labelStyle:
                      TextStyle(color: Theme.of(context).iconTheme.color)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController, //toggel if text is hidden
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Theme.of(context).iconTheme.color)),
            ),
            const SizedBox(height: 20), //Abstandshalter
            TextField(
              controller: passwordController,
              obscureText: obscureText, //toggel if text is hidden
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Theme.of(context).iconTheme.color),
                suffixIcon: IconButton(
                  icon: Icon(
                      !obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                signup(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                    nameController.text.toString(),
                    firstnameController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('Registrieren'),
                ),
              ),
            )
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
