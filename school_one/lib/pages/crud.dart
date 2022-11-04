import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Crud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CrudState();
  }
}

class _CrudState extends State {
  final DocumentReference a =
      FirebaseFirestore.instance.collection("myData").doc("dummy");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {},
          child: Icon(
            Icons.ac_unit,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          "Crud Stuff",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {},
              child: Text(
                "add",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.amber.shade600,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(
                "delete",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightGreenAccent,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(
                "fetch",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.pink.shade600,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(
                "update",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
