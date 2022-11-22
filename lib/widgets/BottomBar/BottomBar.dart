import 'package:flutter/material.dart';
import '/Users/chris/Desktop/DHBW/SE3/SEIII_Flutter_App/lib/widgets/test/testButton.dart';


class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBar();
}

class _MyBottomBar extends State<MyBottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Spiele',
      style: optionStyle,
    ),
    Text(
      'Index 2: Tipps',
      style: optionStyle,
    ),
    Text(
      'Index 3: Benutzer',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Tippspiel'),
        backgroundColor: Color.fromARGB(255, 108, 100, 100),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 108, 100, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Spiele',
            backgroundColor: Color.fromARGB(255, 108, 100, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Tipps',
            backgroundColor: Color.fromARGB(255, 108, 100, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            backgroundColor: Color.fromARGB(255, 108, 100, 100),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
