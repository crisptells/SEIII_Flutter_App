import 'package:flutter/material.dart';
import 'package:flutter_test_app/http_getAllUsersTest.dart';
import 'package:flutter_test_app/http_insertNewUserTest.dart';

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  bool isSwitch = false;
  bool? isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 55, 55),
        title: const Text(
          'Learn Flutter',
          style: TextStyle(
            color: Color.fromARGB(255, 223, 233, 224),
          ),
        ),
        automaticallyImplyLeading:
            false, // automatischer Back Button aus der App Bar weg (bei false)
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 223, 233, 224),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: const Icon(
              Icons.info_outline,
              color: Color.fromARGB(255, 223, 233, 224),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/mj.jpg'),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              color: Colors.blueGrey,
              width:
                  double.infinity, // double.infinty ist die ganze Breite nutzen
              child: const Center(
                child: Text(
                  'This is Text Widget in Container',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSwitch ? Colors.grey : Colors.blue, // true : false
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CreateUser();
                    },
                  ),
                );
                debugPrint('Elevated Button');
              },
              child: const Text('Elevated Button'),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined Button');
              },
              child: const Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('Text Button');
              },
              child: const Text('Text Button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior
                  .opaque, // wenn man das macht kann man in der ganzen row klicken
              onTap: () {
                debugPrint('This ist the Row');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // space evenly = gleichmäßig in der Reihe verteilt
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                  ),
                  Text('Row Widget'),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool newBoolean) {
                setState(() {
                  isSwitch = newBoolean;
                });
              },
            ),
            Checkbox(
              value: isCheckBox,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheckBox = newBool;
                });
              },
            ),
            Image.network(
                'https://logos-world.net/wp-content/uploads/2022/02/SAP-Logo-2000.png'),
          ],
        ),
      ),
    );
  }
  
}
