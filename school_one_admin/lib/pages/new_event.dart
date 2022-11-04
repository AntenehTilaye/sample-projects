import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/event.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class NewEvent extends StatefulWidget {
  NewEvent({Key key}) : super(key: key);

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  TextEditingController namecon;
  TextEditingController desccon;

  @override
  void initState() {
    namecon = TextEditingController();
    desccon = TextEditingController();
    super.initState();
  }

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
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
        getField("Event Name", namecon),
        getField("Description", desccon),
        Container(
            width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.only(left: 20, top: 30),
            child: Text(_dateTime.day.toString() +
                " - " +
                _dateTime.month.toString() +
                " - " +
                _dateTime.year.toString())),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.only(left: 20, top: 30),
          child: Row(
            children: [
              Text(
                "Pick a Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2030),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.date_range,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
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
    Event theEvent = Event(
        eventId: uID.v1(),
        name: namecon.text,
        desc: desccon.text,
        date: _dateTime.toString());

    fire.setEvent(theEvent);
  }
}
