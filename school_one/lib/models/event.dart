import 'package:flutter/material.dart';

class Event {
  final String eventId;
  final String name;
  final String desc;
  final String date;
  final String coverPhoto;

  Event({
    @required this.eventId,
    this.name,
    this.desc,
    this.date,
    this.coverPhoto,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json["eventId"],
      name: json["name"],
      desc: json["desc"],
      date: json["date"],
      coverPhoto: json["cover_photo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'name': name,
      'desc': desc,
      'date': date,
      'cover_photo': coverPhoto,
    };
  }
}
