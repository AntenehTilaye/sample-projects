import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/event.dart';
import 'package:schoolone/pages/event_detail.dart';
import 'package:schoolone/services/firestore_service.dart';

class SchoolEvent extends StatefulWidget {
  final changeMenuLink;
  SchoolEvent({this.changeMenuLink});

  @override
  State<StatefulWidget> createState() {
    return _SchoolEventState(this.changeMenuLink);
  }
}

class _SchoolEventState extends State {
  final changeMenuLink;

  FirestoreService fire = FirestoreService();
  _SchoolEventState(this.changeMenuLink);
  IconData menuIcon = Icons.menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              changeMenuLink();
              if (menuIcon == Icons.menu) {
                setState(() {
                  menuIcon = Icons.arrow_back_ios;
                });
              } else {
                setState(() {
                  menuIcon = Icons.menu;
                });
              }
            },
            child: Icon(
              menuIcon,
              size: 25,
              color: Colors.deepPurple,
            ),
          ),
          title: Text(
            "Events",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: fire.getEvent(),
          builder: (context, snapshot) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return getEventItem(snapshot.data, index, context);
              },
            );
          },
        ),
      ),
    );
  }

  getEventItem(List<Event> theEvent, int index, BuildContext context) {
    if (index == 0) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0),
            margin: EdgeInsets.only(top: 10.0),
            width: MediaQuery.of(context).size.width - 15,
            child: Text(
              "Popular Events",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      animation = CurvedAnimation(
                          parent: animation, curve: Curves.easeInOutExpo);
                      return ScaleTransition(
                          alignment: Alignment.center,
                          scale: animation,
                          child: child);
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return EventDetail(theEvent[index]);
                    },
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange.shade400,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FirebaseImage(theEvent[index].coverPhoto,
                          shouldCache:
                              true, // The image should be cached (default: True)
                          maxSizeBytes:
                              3000 * 1000, // 3MB max file size (default: 2.5MB)
                          cacheRefreshStrategy: CacheRefreshStrategy
                              .NEVER // Switch off update checking
                          ))),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                  child: Text(
                    theEvent[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.easeInOutExpo);
                  return ScaleTransition(
                      alignment: Alignment.center,
                      scale: animation,
                      child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return EventDetail(theEvent[index]);
                },
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepOrange.shade400,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FirebaseImage(theEvent[index].coverPhoto,
                      shouldCache:
                          true, // The image should be cached (default: True)
                      maxSizeBytes:
                          3000 * 1000, // 3MB max file size (default: 2.5MB)
                      cacheRefreshStrategy: CacheRefreshStrategy
                          .NEVER // Switch off update checking
                      ))),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              child: Text(
                theEvent[index].name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
  }
}
