import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/event_photo.dart';
import 'package:schooloneadmin/models/event_video.dart';
import 'package:schooloneadmin/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class NewEventVideo extends StatefulWidget {
  Event theEvent;
  NewEventVideo(this.theEvent, {Key key}) : super(key: key);

  @override
  _NewEventVideoState createState() => _NewEventVideoState(this.theEvent);
}

class _NewEventVideoState extends State<NewEventVideo> {
  TextEditingController namecon;
  Event theEvent;

  _NewEventVideoState(this.theEvent);

  @override
  void initState() {
    namecon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event Video"),
        actions: [
          InkWell(
            onTap: () {
              upsertEvent();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: ListView(children: [
        getField("Event Video", namecon),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.only(left: 20, top: 30),
          child: Text("Event Video location"),
        ),
        SizedBox(height: 200)
      ]),
    );
  }

  Widget getField(name, cont) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade700, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: cont,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: name,
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    );
  }

  void upsertEvent() {
    var uID = Uuid();
    FirestoreService fire = new FirestoreService();
    EventVideo theEventPhoto = EventVideo(
      videoId: uID.v1(),
      video: namecon.text,
      eventId: theEvent.eventId,
    );

    fire.setEventVideo(theEventPhoto);
  }
}
