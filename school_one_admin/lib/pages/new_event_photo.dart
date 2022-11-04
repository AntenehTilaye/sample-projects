import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/event_photo.dart';
import 'package:schooloneadmin/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class NewEventPhoto extends StatefulWidget {
  Event theEvent;
  NewEventPhoto(this.theEvent, {Key key}) : super(key: key);

  @override
  _NewEventPhotoState createState() => _NewEventPhotoState(this.theEvent);
}

class _NewEventPhotoState extends State<NewEventPhoto> {
  TextEditingController namecon;
  Event theEvent;

  _NewEventPhotoState(this.theEvent);

  @override
  void initState() {
    namecon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event Photo"),
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
        getField("Event Photo", namecon),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.only(left: 20, top: 30),
          child: Text("Event Photo location"),
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
    EventPhoto theEventPhoto = EventPhoto(
      photoId: uID.v1(),
      photo: namecon.text,
      eventId: theEvent.eventId,
    );

    fire.setEventPhoto(theEventPhoto);
  }
}
