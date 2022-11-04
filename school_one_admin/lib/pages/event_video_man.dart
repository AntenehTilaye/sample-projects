import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/event_photo.dart';
import 'package:schooloneadmin/pages/new_event.dart';
import 'package:schooloneadmin/pages/new_event_photo.dart';
import 'package:schooloneadmin/pages/new_event_video.dart';
import 'package:schooloneadmin/services/firestore_service.dart';

class EventVideoManager extends StatefulWidget {
  Event theEvent;
  EventVideoManager(this.theEvent, {Key key}) : super(key: key);

  @override
  _EventVideoManagerState createState() =>
      _EventVideoManagerState(this.theEvent);
}

class _EventVideoManagerState extends State {
  FirestoreService fire = FirestoreService();
  Event theEvent;

  _EventVideoManagerState(this.theEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(theEvent.name + " Video Manager"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewEventVideo(theEvent),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.add_circle_outline),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<EventPhoto>>(
        stream: fire.getEventVideo(theEvent.eventId),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      title: Text(snapshot.data.elementAt(index).photoId),
                      subtitle: Text(snapshot.data.elementAt(index).photo),
                      leading: Icon(Icons.info),
                      trailing: InkWell(
                          onTap: () {
                            fire.removeEventPhoto(
                                snapshot.data.elementAt(index).photoId);
                          },
                          child: Icon(Icons.delete)),
                    );
                  },
                );
        },
      ),
    );
  }
}
