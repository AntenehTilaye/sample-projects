import 'package:flutter/material.dart';

class Student {
  final String studentId;
  final String name;
  final String moto;
  final String section;
  final String phone;
  final String email;
  final String facebook;
  final String instagram;
  final String telegram;
  final String department;
  final String photohalf;
  final String photofull;

  Student(
      {@required this.studentId,
      this.name,
      this.phone,
      this.email,
      this.facebook,
      this.instagram,
      this.telegram,
      this.moto,
      this.section,
      this.department,
      this.photohalf,
      this.photofull});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json["studentId"],
      name: json["name"],
      moto: json["moto"],
      phone: json["phone"],
      email: json["email"],
      facebook: json["facebook"],
      instagram: json["instagram"],
      telegram: json["telegram"],
      section: json["section"],
      department: json["department"],
      photofull: json["photofull"],
      photohalf: json["photohalf"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'name': name,
      'moto': moto,
      'phone': phone,
      'email': email,
      'section': section,
      'department': department,
      'photofull': photofull,
      'photohalf': photohalf,
      'facebook': facebook,
      'instagram': instagram,
      'telegram': telegram,
    };
  }
}
