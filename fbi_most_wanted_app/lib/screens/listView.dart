import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/model/people_model.dart';
import 'package:fbi_most_wanted_app/services/network_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Item> _people = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _people = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FBI Most Wanted'),
      ),
      body: _people.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _people.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(
                        'Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        _people[index].title ?? 'N/A',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Nationality',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        _people[index].nationality ?? 'N/A',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
