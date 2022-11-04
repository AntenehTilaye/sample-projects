import 'package:flutter/material.dart';

class EventPhoto {
  final String photoId;
  final String eventId;
  final String photo;

  EventPhoto({@required this.photoId, this.eventId, this.photo});

  factory EventPhoto.fromJson(Map<String, dynamic> json) {
    return EventPhoto(
      photoId: json["photoId"],
      eventId: json["eventId"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoId': photoId,
      'eventId': eventId,
      'photo': photo,
    };
  }
}
