import 'package:flutter/material.dart';

const int itemCount = 20;

class NachhilfePage extends StatelessWidget {
  const NachhilfePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Kurs ${(index+1)}'),
          leading: const Icon(Icons.school),
          trailing: const Icon(Icons.select_all),
          onTap: (){
            debugPrint('Kurs ${(index+1)} selected');
          },
        );
      },
    );
  }
}
