import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooloneadmin/models/student.dart';
import 'package:schooloneadmin/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EditStudent extends StatefulWidget {
  Student student;
  EditStudent(this.student, {Key key}) : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState(this.student);
}

class _EditStudentState extends State<EditStudent> {
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
  Student student;
  _EditStudentState(this.student);

  @override
  void initState() {
    namecon =
        TextEditingController(text: student.name == null ? "" : student.name);
    motocon =
        TextEditingController(text: student.moto == null ? "" : student.moto);
    phonecon =
        TextEditingController(text: student.phone == null ? "" : student.phone);
    emailcon =
        TextEditingController(text: student.email == null ? "" : student.email);
    departmentcon = TextEditingController(
        text: student.department == null ? "" : student.department);
    sectioncon = TextEditingController(
        text: student.section == null ? "" : student.section);
    instagramcon = TextEditingController(
        text: student.instagram == null ? "" : student.instagram);
    facebookcon = TextEditingController(
        text: student.facebook == null ? "" : student.facebook);
    telegramcon = TextEditingController(
        text: student.telegram == null ? "" : student.telegram);
    fullcon = TextEditingController(
        text: student.photofull == null ? "" : student.photofull);
    halfcon = TextEditingController(
        text: student.photohalf == null ? "" : student.photohalf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
        actions: [
          InkWell(
            onTap: () {
              upsertStudent();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.update),
            ),
          )
        ],
      ),
      body: ListView(children: [
        getField("Full Name", namecon, student.name),
        getField("Moto", motocon, student.moto),
        getField("Phone", phonecon, student.phone),
        getField("Email", emailcon, student.email),
        getField("Department", departmentcon, student.department),
        getField("Section", sectioncon, student.section),
        getField("Facebook", facebookcon, student.facebook),
        getField("Telegram", telegramcon, student.name),
        getField("Instagram", instagramcon, student.telegram),
        getField("Half Photo", halfcon, student.photohalf),
        getField("Full Photo", fullcon, student.photofull),
        SizedBox(height: 200)
      ]),
    );
  }

  Widget getField(name, cont, val) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade700, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
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
    FirestoreService fire = new FirestoreService();
    Student theStudent = Student(
        studentId: student.studentId,
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
    Navigator.pop(context);
  }
}
