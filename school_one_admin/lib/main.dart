import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schooloneadmin/pages/admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.black54,
          primaryColor: Colors.deepPurple.shade400),
      home: Admin()));
}
