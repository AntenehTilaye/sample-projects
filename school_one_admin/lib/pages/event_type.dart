import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/event_photo.dart';
import 'package:schooloneadmin/pages/event_photo_man.dart';
import 'package:schooloneadmin/pages/event_video_man.dart';
import 'package:schooloneadmin/pages/new_event.dart';
import 'package:schooloneadmin/pages/new_event_photo.dart';
import 'package:schooloneadmin/services/firestore_service.dart';

class EventType extends StatefulWidget {
  Event theEvent;
  EventType(this.theEvent, {Key key}) : super(key: key);

  @override
  _EventTypeState createState() => _EventTypeState(this.theEvent);
}

class _EventTypeState extends State {
  FirestoreService fire = FirestoreService();
  Event theEvent;

  _EventTypeState(this.theEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(theEvent.name + " Event Type"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewEventPhoto(theEvent),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.add_circle_outline),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventVideoManager(theEvent),
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 40),
                width: MediaQuery.of(context).size.width - 40,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(
                        width: 3, color: Colors.deepPurple.shade300)),
                child: Center(
                    child: Text("Video Manager",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventPhotoManager(theEvent),
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 40),
                width: MediaQuery.of(context).size.width - 40,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(
                        width: 3, color: Colors.deepPurple.shade300)),
                child: Center(
                    child: Text("Photo Manager",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
          ],
        ));
  }
}
