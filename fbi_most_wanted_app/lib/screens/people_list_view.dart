import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/model/person.dart';
import 'package:fbi_most_wanted_app/model/people.dart';
import 'package:fbi_most_wanted_app/screens/person_details_view.dart';
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
          : GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _people.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonDetailView(person: _people[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            _people[index].images?.isNotEmpty == true
                                ? _people[index].images![0]
                                : "https://via.placeholder.com/150",
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              _titleFormatterFor(_people[index].title ?? "N/A"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Private

  late List<Person> _people = [];

  Text _titleFormatterFor(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  void _getData() async {
    _people = (await ApiService.instance.getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
}
