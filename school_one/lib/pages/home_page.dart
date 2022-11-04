import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/student.dart';
import 'package:schoolone/pages/department_students.dart';
import 'package:schoolone/pages/student_detail.dart';
import 'package:schoolone/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  final changeMenuLink;
  HomePage({this.changeMenuLink});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState(this.changeMenuLink);
  }
}

List<String> departments = [
  "Computer Science",
  "Electrical Engineering",
  "Mechanical Engineering",
  "Applied Science",
  "Chemical Engineering",
  "Textile Engineering",
  "Law"
];

class _HomePageState extends State {
  var currentPage = 0.0;
  var currentPage2 = 0.0;
  PageController controller = PageController(viewportFraction: 0.8);
  PageController controller2 = PageController(viewportFraction: 0.8);
  IconData menuIcon = Icons.menu;
  FirestoreService fire = FirestoreService();

  final changeMenuLink;
  _HomePageState(this.changeMenuLink);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      var next = controller.page.round() + 0.0;
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });

    controller2.addListener(() {
      var next = controller2.page.round() + 0.0;
      if (currentPage2 != next) {
        setState(() {
          currentPage2 = next;
        });
      }
    });

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
            "Graduation Albem",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.0),
              margin: EdgeInsets.only(top: 5.0, bottom: 10),
              width: MediaQuery.of(context).size.width - 15,
              child: Text(
                "Trending",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: StreamBuilder(
                stream: fire.getStudent(),
                builder: (context, snapshot) {
                  return PageView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    controller: controller,
                    itemBuilder: (context, index) {
                      bool active = currentPage == index;
                      return _buildSlideItem(snapshot.data, index, active);
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              margin: EdgeInsets.only(top: 5.0, bottom: 10),
              width: MediaQuery.of(context).size.width - 15,
              child: Text(
                "Departments",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5, bottom: 10),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  bool active = currentPage == index;
                  return _buildDepartmenyItem(departments, index, active);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              margin: EdgeInsets.only(top: 10.0, bottom: 10),
              width: MediaQuery.of(context).size.width - 15,
              child: Text(
                "Favorites",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: StreamBuilder(
                stream: fire.getStudent(),
                builder: (context, snapshot) {
                  return PageView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    controller: controller2,
                    itemBuilder: (context, index) {
                      bool active = currentPage2 == index;
                      return _buildSlideItem(snapshot.data, index, active);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlideItem(List<Student> students, int index, bool active) {
    final double blur = active ? 10 : 0;
    final double offset = active ? 5 : 0;
    final double top = active ? 5 : 30;
    final double bottom = active ? 10 : 30;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: bottom, right: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: FirebaseImage(students[index].photofull,
                    shouldCache:
                        true, // The image should be cached (default: True)
                    maxSizeBytes:
                        3000 * 1000, // 3MB max file size (default: 2.5MB)
                    cacheRefreshStrategy:
                        CacheRefreshStrategy.NEVER // Switch off update checking
                    ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
              child: Text(
                students[index].moto,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              margin: EdgeInsets.only(bottom: 5.0, left: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Text(
                students[index].name,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmenyItem(List<String> students, int index, bool active) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepartmentStudent(students[index]),
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.only(bottom: 5.0, left: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.deepPurple),
          ),
          child: Text(
            students[index],
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget getPostItem(List<Student> students, int index, BuildContext context) {
    if (index == 0) {
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
                  return StudentDetail(students[index]);
                },
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: 400,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
      );
    }
  }
}
