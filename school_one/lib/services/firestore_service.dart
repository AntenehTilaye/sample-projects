import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:schoolone/models/event.dart';
import 'package:schoolone/models/event_photo.dart';
import 'package:schoolone/models/event_video.dart';
import 'package:schoolone/models/student.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // get data
  // Student
  Stream<List<Student>> getStudent() {
    return _db.collection("student").snapshots().map((snap) =>
        snap.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  // Student
  Stream<List<Student>> getDeptStudent(String dept) {
    return _db
        .collection("student")
        .where("department", isEqualTo: dept)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  // Event
  Stream<List<Event>> getEvent() {
    return _db.collection("event").snapshots().map(
        (snap) => snap.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }

  // Event Photo
  Stream<List<EventPhoto>> getEventPhoto(String theId) {
    return _db
        .collection("eventphoto")
        .where("eventId", isEqualTo: theId)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => EventPhoto.fromJson(doc.data())).toList());
  }

  // upsert
  // student
  Future<void> setStudent(Student student) {
    var options = SetOptions(merge: true);
    return _db
        .collection("student")
        .doc(student.studentId)
        .set(student.toMap(), options);
  }

  // Event
  Future<void> setEvent(Event event) {
    var options = SetOptions(merge: true);
    return _db
        .collection("event")
        .doc(event.eventId)
        .set(event.toMap(), options);
  }

  // Event Photo
  Future<void> setEventPhoto(EventPhoto eventphoto) {
    var options = SetOptions(merge: true);
    return _db
        .collection("eventphoto")
        .doc(eventphoto.photoId)
        .set(eventphoto.toMap(), options);
  }

  // Event video
  Stream<List<EventVideo>> getEventVideo(String theId) {
    return _db
        .collection("event_video")
        .where("eventId", isEqualTo: theId)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => EventVideo.fromJson(doc.data())).toList());
  }

  // delete
  // student
  Future<void> removeStudent(String studentId) {
    return _db.collection("student").doc(studentId).delete();
  }

  // Event
  Future<void> removeEvent(String theId) {
    return _db.collection("event").doc(theId).delete();
  }

  // Event Photo
  Future<void> removeEventPhoto(String theId) {
    return _db.collection("eventphoto").doc(theId).delete();
  }

  // Event Photo
  Future<void> removeEventVideo(String theId) {
    return _db.collection("event_video").doc(theId).delete();
  }

  // load Image from Storage
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    debugPrint(FirebaseStorage.instance.ref().name);
    return await FirebaseStorage.instance
        .ref()
        .child("student_photo")
        .child(image)
        .getDownloadURL();
  }

  Future<String> getImageUrl(BuildContext context, String image) async {
    String m;
    await FirestoreService.loadImage(context, image).then((downloadUrl) {
      m = downloadUrl.toString();
    });
    return m;
  }

  Future<Widget> getImage(BuildContext context, String image) async {
    Image m;
    await FirestoreService.loadImage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return m;
  }

  // Event Video
  Future<void> setEventVideo(EventVideo item) {
    var options = SetOptions(merge: true);
    return _db
        .collection("event_video")
        .doc(item.videoId)
        .set(item.toMap(), options);
  }
}
