import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/student.dart';
import 'package:schoolone/pages/student_detail.dart';
import 'package:schoolone/services/firestore_service.dart';

class Favorite extends StatefulWidget {
  final changeMenuLink;
  Favorite({this.changeMenuLink});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteState(this.changeMenuLink);
  }
}

class _FavoriteState extends State {
  var currentPage = 1.0;
  PageController controller = PageController(viewportFraction: 0.8);
  IconData menuIcon = Icons.menu;

  FirestoreService fire = FirestoreService();
  final changeMenuLink;
  _FavoriteState(this.changeMenuLink);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.white,
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
              color: Colors.deepPurple,
            ),
          ),
          title: Text(
            "Favorites",
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
          stream: fire.getStudent(),
          builder: (context, snapshot) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return getPostItem(snapshot.data, index, context);
              },
            );
          },
        ),
      ),
    );
  }
}

Widget getPostItem(List<Student> students, int index, BuildContext context) {
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
                  alignment: Alignment.center, scale: animation, child: child);
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return StudentDetail(students[index]);
            },
          ));
    },
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          margin: EdgeInsets.only(top: 15, left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
                image: FirebaseImage(students[index].photofull,
                    shouldCache:
                        true, // The image should be cached (default: True)
                    maxSizeBytes:
                        3000 * 1000, // 3MB max file size (default: 2.5MB)
                    cacheRefreshStrategy:
                        CacheRefreshStrategy.NEVER // Switch off update checking
                    ),
                fit: BoxFit.cover),
          ),
          child: Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(top: 5, left: 5, right: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black38, width: 3),
                    image: DecorationImage(
                      image: FirebaseImage(students[index].photofull,
                          shouldCache:
                              true, // The image should be cached (default: True)
                          maxSizeBytes:
                              3000 * 1000, // 3MB max file size (default: 2.5MB)
                          cacheRefreshStrategy: CacheRefreshStrategy
                              .NEVER // Switch off update checking
                          ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                  ),
                  child: Text(
                    students[index].name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
          ),
          child: Text(
            students[index].moto,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
