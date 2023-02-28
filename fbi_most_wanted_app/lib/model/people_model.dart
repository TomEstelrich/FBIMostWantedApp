import 'dart:convert';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

String peopleToJson(People data) => json.encode(data.toJson());

class People {
  People({
    this.items,
  });

  int? total;
  List<Item>? items;
  int? page;

  factory People.fromJson(Map<String, dynamic> json) => People(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.title,
    this.nationality,
  });

  String? id;
  String? title;
  String? nationality;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["@id"],
        title: json["title"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "title": title,
        "nationality": nationality,
      };
}
