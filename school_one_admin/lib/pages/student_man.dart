import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/pages/edit_student.dart';
import 'package:schooloneadmin/pages/new_student.dart';
import 'package:schooloneadmin/services/firestore_service.dart';

class StudentManger extends StatefulWidget {
  StudentManger({Key key}) : super(key: key);

  @override
  _StudentMangerState createState() => _StudentMangerState();
}

class _StudentMangerState extends State {
  FirestoreService fire = FirestoreService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Manager"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewStudent(),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.add_circle_outline),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewStudent(),
          ));
        },
      ),
      body: StreamBuilder<List<Student>>(
        stream: fire.getStudent(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudent(
                                    snapshot.data.elementAt(index),
                                  ),
                                ));
                          },
                          child: Icon(Icons.edit)),
                      InkWell(
                          onTap: () {
                            fire.removeStudent(
                                snapshot.data.elementAt(index).studentId);
                          },
                          child: Icon(Icons.delete)),
                    ],
                  ),
                ),
                title: Text(snapshot.data.elementAt(index).name),
                subtitle: Text(snapshot.data.elementAt(index).photofull),
                leading: Container(
                  width: 50,
                  height: 50,
                  child: FutureBuilder(
                    future: fire.getImage(
                        context, snapshot.data.elementAt(index).photofull),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.25,
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: snapshot.data,
                        );

                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: CircularProgressIndicator());

                      return Container();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
