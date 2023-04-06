import 'package:flutter/material.dart';
import 'package:fbi_most_wanted_app/model/person.dart';
import 'package:fbi_most_wanted_app/model/people.dart';
import 'package:flutter_html/flutter_html.dart';

class PersonDetailView extends StatelessWidget {
  final Person person;

  const PersonDetailView({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.title ?? "N/A"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              person.images?.isNotEmpty == true
                  ? person.images![0]
                  : "https://via.placeholder.com/150",
              width: double.infinity,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            _addInfoRow("Title", person.title),
            SizedBox(height: 8.0),
            _addInfoRow('Place of Birth', person.placeOfBirth),
            SizedBox(height: 8.0),
            _addInfoRow("Gender", person.gender),
            SizedBox(height: 8.0),
            _addInfoRow("Race", person.race),
            SizedBox(height: 8.0),
            _addInfoRow("Weight", person.weight),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Html(
                data: person.details != null
                    ? person.details
                    : person.caution != null
                        ? person.caution
                        : "Description not available.",
                style: {
                  'p': Style.fromTextStyle(TextStyle(fontSize: 16.0)),
                },
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // Private

  Padding _addInfoRow(String concept, String? data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            "${concept}:",
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 8.0),
          Text(
            "${data ?? "N/A"}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
