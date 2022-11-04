import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/pages/event_man.dart';
import 'package:schooloneadmin/pages/student_man.dart';

class Admin extends StatefulWidget {
  Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Console"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentManger(),
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
                    child: Text("Student Manager",
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
                      builder: (context) => EventManager(),
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
                    child: Text("Event Manager",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
