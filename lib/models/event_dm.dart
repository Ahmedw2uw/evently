import 'package:evently/models/categort_dm.dart';
import 'package:flutter/material.dart';

class EventDm {
  static const String colictionName = "events";
  late String id;
  late String title;
  late DateTime date;
  late String category;
  // bool isFavorate;
  late String description;
  late TimeOfDay time;
  late double? lat; //*lat,long-> there to the lines in map
  late double? long;

  late String ownerId;
  EventDm({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    // required this.isFavorate,
    required this.description,
    this.lat,
    this.long,
    required this.time,
    required this.ownerId,
  });
  String get image {
    return CategorytDm.homeCategories
        .firstWhere(
          (cat) => cat.title.toLowerCase() == category.toLowerCase(),
          orElse: () => CategorytDm.homeCategories[0],
        )
        .image;
  }

  EventDm.fromJson(Map json) {
    id = json["id"] ?? "";
    title = json["title"] ?? "";
    date = DateTime.tryParse(json["date"] ?? "") ?? DateTime.now();

    String timeStr = json["time"] ?? "0:0";
    List<String> parts = timeStr.split(":");
    time = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );

    category = json["category"] ?? "";
    description = json["description"] ?? "";
    ownerId = json["ownerId"] ?? "";
    lat = json["lat"]?.toDouble();
    long = json["long"]?.toDouble();
  }

  Map<String, dynamic> tojson() {
    return {
      //* thete add the data to an empty document
      "title": title,
      "id": id, //* to taik the event id from firestore
      "ownerId": ownerId,
      "description": description,
      "date": date.toIso8601String(), // 🔁 نحوله لصيغة String
      "time": "${time.hour}:${time.minute}", // 🔁 نحول TimeOfDay إلى String
      "category": image,
    };
  }
}
