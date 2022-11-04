import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/student.dart';

class StudentDetail extends StatefulWidget {
  Student student_detail;

  StudentDetail(this.student_detail);

  @override
  State<StatefulWidget> createState() {
    return _StudentDetailState(this.student_detail);
  }
}

class _StudentDetailState extends State {
  Student student_detail;
  _StudentDetailState(this.student_detail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: FirebaseImage(student_detail.photofull,
                        shouldCache:
                            true, // The image should be cached (default: True)
                        maxSizeBytes:
                            3000 * 1000, // 3MB max file size (default: 2.5MB)
                        cacheRefreshStrategy: CacheRefreshStrategy
                            .NEVER // Switch off update checking
                        ),
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
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 5,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height - 85),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                margin:
                                    EdgeInsets.only(top: 5, left: 5, right: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.black38, width: 3),
                                  image: DecorationImage(
                                    image: FirebaseImage(
                                        student_detail.photofull,
                                        shouldCache:
                                            true, // The image should be cached (default: True)
                                        scale: 0.3,
                                        cacheRefreshStrategy: CacheRefreshStrategy
                                            .NEVER // Switch off update checking
                                        ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  student_detail.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              student_detail.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.brown.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 5,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin:
                                    EdgeInsets.only(top: 5, left: 5, right: 0),
                                child: Icon(Icons.date_range),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  "12/23/2001",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin:
                                    EdgeInsets.only(top: 5, left: 5, right: 0),
                                child: Icon(Icons.departure_board),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  "Natual Science",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin:
                                    EdgeInsets.only(top: 5, left: 5, right: 0),
                                child: Icon(Icons.call_split),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  "Section 1",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
