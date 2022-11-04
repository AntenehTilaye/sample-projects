import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/student.dart';
import 'package:schoolone/pages/student_detail.dart';
import 'package:schoolone/services/firestore_service.dart';

class DepartmentStudent extends StatefulWidget {
  String depart;
  DepartmentStudent(this.depart);

  @override
  State<StatefulWidget> createState() {
    return _DepartmentStudentState(this.depart);
  }
}

class _DepartmentStudentState extends State {
  var currentPage = 1.0;
  PageController controller = PageController(viewportFraction: 0.8);
  IconData menuIcon = Icons.menu;

  FirestoreService fire = FirestoreService();
  String depart;
  _DepartmentStudentState(this.depart);

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
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.deepPurple,
            ),
          ),
          title: Text(
            depart + " Students",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: fire.getDeptStudent(depart),
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
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      margin: EdgeInsets.only(top: 15, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: FirebaseImage(students[index].photofull,
                shouldCache: true, // The image should be cached (default: True)
                maxSizeBytes: 3000 * 1000, // 3MB max file size (default: 2.5MB)
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
                      shouldCache: true,
                      scale: 0.3, // 3MB max file size (default: 2.5MB)
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
