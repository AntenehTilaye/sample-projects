import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class NewStudent extends StatefulWidget {
  NewStudent({Key key}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  TextEditingController namecon;
  TextEditingController motocon;
  TextEditingController phonecon;
  TextEditingController emailcon;
  TextEditingController departmentcon;
  TextEditingController sectioncon;
  TextEditingController instagramcon;
  TextEditingController facebookcon;
  TextEditingController telegramcon;
  TextEditingController fullcon;
  TextEditingController halfcon;

  @override
  void initState() {
    namecon = TextEditingController();
    motocon = TextEditingController();
    phonecon = TextEditingController();
    emailcon = TextEditingController();
    departmentcon = TextEditingController();
    sectioncon = TextEditingController();
    instagramcon = TextEditingController();
    facebookcon = TextEditingController();
    telegramcon = TextEditingController();
    fullcon = TextEditingController();
    halfcon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
        actions: [
          InkWell(
            onTap: () {
              upsertStudent();
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
        getField("Full Name", namecon),
        getField("Moto", motocon),
        getField("Phone", phonecon),
        getField("Email", emailcon),
        getField("Department", departmentcon),
        getField("Section", sectioncon),
        getField("Facebook", facebookcon),
        getField("Telegram", telegramcon),
        getField("Instagram", instagramcon),
        getField("Half Photo", halfcon),
        getField("Full Photo", fullcon),
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

  void upsertStudent() {
    var uID = Uuid();
    FirestoreService fire = new FirestoreService();
    Student theStudent = Student(
        studentId: uID.v1(),
        name: namecon.text,
        moto: motocon.text,
        phone: phonecon.text,
        email: emailcon.text,
        department: departmentcon.text,
        section: sectioncon.text,
        facebook: facebookcon.text,
        instagram: instagramcon.text,
        telegram: telegramcon.text,
        photofull: fullcon.text,
        photohalf: halfcon.text);

    fire.setStudent(theStudent);
  }
}
