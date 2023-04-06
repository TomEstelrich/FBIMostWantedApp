import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/model/person.dart';
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
    _getData(_currentPage);
  }

  // Internal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FBI Most Wanted')),
      body: _isLoading && _people.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.extentAfter == 0) {
                  _loadMore();
                  return true;
                }
                return false;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: _people.length + (_isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == _people.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
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
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
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
                            child: _titleFormatterFor(
                                _people[index].title ?? "N/A"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  // Private

  late List<Person> _people = [];
  bool _isLoading = false;
  int _currentPage = 1;

  Future<void> _getData(int page) async {
    setState(() {
      _isLoading = true;
    });
    final people = await ApiService.instance.getUsers(page);
    setState(() {
      _isLoading = false;
      _people.addAll(people ?? []);
    });
  }

  void _loadMore() {
    if (_isLoading) return;
    _currentPage++;
    _getData(_currentPage);
  }

  Text _titleFormatterFor(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
