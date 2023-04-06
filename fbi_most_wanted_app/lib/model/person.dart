import 'dart:convert';

class Person {
  Person({
    this.id,
    this.title,
    this.race,
    this.gender,
    this.weight,
    this.placeOfBirth,
    this.details,
    this.caution,
    this.images,
  });

  String? id;
  String? title;
  String? race;
  String? gender;
  String? weight;
  String? placeOfBirth;
  String? details;
  String? caution;
  List<String>? images;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["@id"],
        title: json["title"],
        race: json["race_raw"],
        gender: json["sex"],
        weight: json["weight"],
        placeOfBirth: json["place_of_birth"],
        details: json["details"],
        caution: json["caution"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x["original"]))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "title": title,
        "race": race,
        "gender": gender,
        "weight": weight,
        "placeOfBirth": placeOfBirth,
        "details": details,
        "caution": caution,
        "images": images?.map((x) => {"original": x}).toList(),
      };
}
