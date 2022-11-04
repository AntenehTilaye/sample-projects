import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final changeMenuLink;

  About({this.changeMenuLink});

  @override
  State<StatefulWidget> createState() {
    return _AboutState(this.changeMenuLink);
  }
}

class _AboutState extends State {
  var currentPage = 1.0;
  PageController controller = PageController(viewportFraction: 0.8);
  IconData menuIcon = Icons.menu;

  final changeMenuLink;
  _AboutState(this.changeMenuLink);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "About",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}