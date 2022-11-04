import 'package:flutter/material.dart';

class EventImageViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventImageViewerState();
  }
}

class _EventImageViewerState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage("assets/event1.jpg"),
                fit: BoxFit.fitWidth,
              )),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 30),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ));
  }
}
