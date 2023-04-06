import 'dart:convert';
import 'package:fbi_most_wanted_app/model/person.dart';

class People {
  // Lifecycle

  People({
    this.items,
  });

  int? total;
  List<Person>? items;
  int? page;

  // Internal

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
