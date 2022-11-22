import 'package:flutter/material.dart';
import './widgets/BottomBar/BottomBar.dart';

void main() => runApp(const MyMainApp());

class MyMainApp extends StatelessWidget {
  const MyMainApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyBottomBar(),
      
    );
  }
}
