import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/pages/edit_student.dart';
import 'package:schooloneadmin/pages/event_photo_man.dart';
import 'package:schooloneadmin/pages/event_type.dart';
import 'package:schooloneadmin/pages/new_event.dart';
import 'package:schooloneadmin/services/firestore_service.dart';

class EventManager extends StatefulWidget {
  EventManager({Key key}) : super(key: key);

  @override
  _EventManagerState createState() => _EventManagerState();
}

class _EventManagerState extends State {
  FirestoreService fire = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Manager"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewEvent(),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.add_circle_outline),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<Event>>(
        stream: fire.getEvent(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventType(snapshot.data.elementAt(index)),
                            ));
                      },
                      title: Text(snapshot.data.elementAt(index).name),
                      subtitle: Text(snapshot.data.elementAt(index).desc),
                      leading: Icon(Icons.info),
                      trailing: InkWell(
                          onTap: () {
                            fire.removeEvent(
                                snapshot.data.elementAt(index).eventId);
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
