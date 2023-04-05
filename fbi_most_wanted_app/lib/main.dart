import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/screens/listView.dart';

void main() => runApp(const FBIMostWantedApp());

class FBIMostWantedApp extends StatelessWidget {
  const FBIMostWantedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: PeopleListView(),
    );
  }
}
