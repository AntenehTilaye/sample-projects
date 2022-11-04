import 'package:flutter/material.dart';

class EventVideo {
  final String videoId;
  final String eventId;
  final String video;

  EventVideo({@required this.videoId, this.eventId, this.video});

  factory EventVideo.fromJson(Map<String, dynamic> json) {
    return EventVideo(
      videoId: json["photoId"],
      eventId: json["eventId"],
      video: json["photo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoId': videoId,
      'eventId': eventId,
      'photo': video,
    };
  }
}
