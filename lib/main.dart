import 'package:flutter/material.dart';
import 'package:flutter_test_app/events_page.dart';
import 'package:flutter_test_app/home_page.dart';
import 'package:flutter_test_app/account_page.dart';
import 'package:flutter_test_app/nachhilfe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const RootPage(),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nachhilfe',
          style: TextStyle(color: Color.fromARGB(255, 223, 233, 224)),
        ),
        backgroundColor: const Color.fromARGB(255, 57, 55, 55),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 223, 233, 224),
            ),
          ),
        ],
      ),
      body: pages[
          currentPage], // hier wird die Liste aufgerufen --> dann wird die entsprechende Seite angezeigt
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Text in Terminal');
        },
        backgroundColor: const Color.fromARGB(255, 57, 55, 55),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 223, 233, 224),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 57, 55, 55),
        mouseCursor: SystemMouseCursors.grab,
        selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 223, 233, 224), size: 30), // Icon Color
        selectedItemColor:
            const Color.fromARGB(255, 223, 233, 224), // Text Color
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
}
