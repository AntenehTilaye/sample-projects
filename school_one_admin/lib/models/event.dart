import 'package:flutter/material.dart';

class Event {
  final String eventId;
  final String name;
  final String desc;
  final String date;

  Event({
    @required this.eventId,
    this.name,
    this.desc,
    this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json["eventId"],
      name: json["name"],
      desc: json["desc"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'name': name,
      'desc': desc,
      'date': date,
    };
  }
}
