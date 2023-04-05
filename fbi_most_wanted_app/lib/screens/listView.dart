import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/model/people_model.dart';
import 'package:fbi_most_wanted_app/services/network_service.dart';

class PeopleListView extends StatefulWidget {
  const PeopleListView({Key? key}) : super(key: key);

  @override
  _PeopleListViewState createState() => _PeopleListViewState();
}

class _PeopleListViewState extends State<PeopleListView> {
  // Lifecycle

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Internal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FBI Most Wanted')),
      body: _people.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _people.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      _nameText,
                      Text(
                        _people[index].title ?? 'N/A',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _nationalityText,
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

  // Private

  late List<Item> _people = [];

  var _nameText = Text(
    'Name',
    textAlign: TextAlign.left,
    style: TextStyle(fontSize: 15),
  );

  var _nationalityText = Text(
    'Nationality',
    textAlign: TextAlign.left,
    style: TextStyle(fontSize: 15),
  );

  void _getData() async {
    _people = (await ApiService.instance.getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
}
