import 'package:flutter/material.dart';
import 'package:flutter_test_app/events_page.dart';
import 'package:flutter_test_app/home_page.dart';
import 'package:flutter_test_app/account_page.dart';
import 'package:flutter_test_app/nachhilfe_page.dart';
import 'package:flutter_test_app/settings_page.dart';
import 'package:flutter_test_app/theme.dart';
import 'package:provider/provider.dart';

import 'learn_flutter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const RootPage(),
          );
        },
      ),
    );
    /**  return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(themeChangeProvider.darkTheme, context),
      home: const RootPage(),
    );
    */
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<String> dropList = <String>['Eins', 'Zwei', 'Drei'];

  List<Widget> pages = const [
    // Liste aller Seiten
    HomePage(), // 0
    NachhilfePage(),
    EventPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'StudyRight',
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.white),
            child: PopupMenuButton<int>(
              color: const Color.fromRGBO(64, 75, 96, .9),
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
      body: pages[
          currentPage], // hier wird die Liste aufgerufen --> dann wird die entsprechende Seite angezeigt
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1),
        mouseCursor: SystemMouseCursors.grab,
        selectedIconTheme:
            const IconThemeData(color: Colors.white, size: 30), // Icon Color
        selectedItemColor:
            const Color.fromARGB(255, 255, 255, 255), // Text Color
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 189, 190, 189)),
        unselectedItemColor: const Color.fromARGB(255, 189, 190, 189),
        showSelectedLabels: true, // Label von Navigation bar zeigen oder nicht
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Nachhilfe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Termine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: currentPage,
        onTap: _onItemTapped,
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
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LearnFlutterPage()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const LearnFlutterPage())); // wenn richtige Login Seite da ist dann pushAndRemoveUntil
        break;
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(58, 66, 86, 1),
          title: const Text(
            'Kurs hinzufügen',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: SizedBox(
            height: 230,
            child: Column(
              children: const [
                Text(
                  'Kurs:                                                            ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Dozent:                                                      ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
              ),
              child: const Text(
                'Zurück',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: const Color.fromRGBO(
                    64, 75, 96, .9), // heller Color.fromRGBO(64, 75, 96, .9)
              ), // dunkler Color.fromRGBO(58, 66, 86, 1)
              child: const Text(
                'Hinzufügen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
