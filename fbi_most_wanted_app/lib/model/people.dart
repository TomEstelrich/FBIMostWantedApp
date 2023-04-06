import 'dart:convert';
import 'package:fbi_most_wanted_app/model/person.dart';

People peopleFromJson(String str) => People.fromJson(json.decode(str));
String peopleToJson(People data) => json.encode(data.toJson());

class People {
  People({
    this.items,
  });

  int? total;
  List<Person>? items;
  int? page;

  factory People.fromJson(Map<String, dynamic> json) => People(
        items: json["items"] == null
            ? []
            : List<Person>.from(json["items"]!.map((x) => Person.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
