import 'package:flutter/material.dart';

void main() {
  runApp(const FBIMostWantedApp());
}

class FBIMostWantedApp extends StatelessWidget {
  const FBIMostWantedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MostWantedList(),
    );
  }
}

class MostWantedList extends StatefulWidget {
  const MostWantedList({super.key});
  // final String title;

  @override
  State<MostWantedList> createState() => _MostWantedListState();
}

class _MostWantedListState extends State<MostWantedList> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FBI Most Wanted'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListBody(
              children: [Text('Demo'), Text('Demo 2')],
            ),
          ],
        ),
      ),
    );
  }
}
