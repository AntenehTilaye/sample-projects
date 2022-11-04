import 'package:flutter/material.dart';
import 'package:schoolone/pages/about.dart';
import 'package:schoolone/pages/committe.dart';
import 'package:schoolone/pages/favorite.dart';
import 'package:schoolone/pages/game.dart';
import 'package:schoolone/pages/home_page.dart';
import 'package:schoolone/pages/school.dart';
import 'package:schoolone/pages/school_event.dart';

class BackBone extends StatefulWidget {
  @override
  _BackBoneState createState() => _BackBoneState();
}

class _BackBoneState extends State {
  Widget _currentPage;
  int currentIndex = 0;
  bool isOpened = false;

  Color _selectedColor = Colors.deepPurple.shade800;
  Color _noSelectedColor = Colors.deepPurple;

  Color homeColor = Colors.deepPurple.shade800;
  Color eventColor = Colors.deepPurple;
  Color favColor = Colors.deepPurple;
  Color gameColor = Colors.deepPurple;
  Color comColor = Colors.deepPurple;
  Color schoolColor = Colors.deepPurple;
  Color aboutColor = Colors.deepPurple;

  changeMenu() {
    setState(() {
      isOpened = !isOpened;
    });
    print("Boom");
  }

  @override
  void initState() {
    super.initState();
    _currentPage = HomePage(changeMenuLink: changeMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          theMenu(),
          thePage(),
        ],
      ),
    );
  }

  Duration _animatedDuration = Duration(milliseconds: 500);
  Widget theMenu() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.deepPurple,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.perm_identity,
                      color: Colors.black54,
                    ),
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      "The best School",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.45,
                    color: Colors.grey.shade600,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex != 0) {
                          _currentPage = HomePage(changeMenuLink: changeMenu);
                          isOpened = false;
                          homeColor = _selectedColor;
                          eventColor = _noSelectedColor;
                          favColor = _noSelectedColor;
                          gameColor = _noSelectedColor;
                          comColor = _noSelectedColor;
                          schoolColor = _noSelectedColor;
                          aboutColor = _noSelectedColor;
                          currentIndex = 0;
                        }
                      });
                    },
                    child: menuItem(Icons.home, "Home", homeColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex != 1) {
                          _currentPage =
                              SchoolEvent(changeMenuLink: changeMenu);
                          isOpened = false;
                          homeColor = _noSelectedColor;
                          eventColor = _selectedColor;
                          favColor = _noSelectedColor;
                          gameColor = _noSelectedColor;
                          comColor = _noSelectedColor;
                          schoolColor = _noSelectedColor;
                          aboutColor = _noSelectedColor;
                          currentIndex = 1;
                        }
                      });
                    },
                    child: menuItem(Icons.event, "Events", eventColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex != 2) {
                          _currentPage = Favorite(changeMenuLink: changeMenu);
                          isOpened = false;
                          homeColor = _noSelectedColor;
                          eventColor = _noSelectedColor;
                          favColor = _selectedColor;
                          gameColor = _noSelectedColor;
                          comColor = _noSelectedColor;
                          schoolColor = _noSelectedColor;
                          aboutColor = _noSelectedColor;
                          currentIndex = 2;
                        }
                      });
                    },
                    child: menuItem(Icons.favorite, "Favorites", favColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex != 3) {
                          _currentPage = Game(changeMenuLink: changeMenu);
                          isOpened = false;
                          homeColor = _noSelectedColor;
                          eventColor = _noSelectedColor;
                          favColor = _noSelectedColor;
                          gameColor = _selectedColor;
                          comColor = _noSelectedColor;
                          schoolColor = _noSelectedColor;
                          aboutColor = _noSelectedColor;
                          currentIndex = 3;
                        }
                      });
                    },
                    child: menuItem(Icons.games, "Games", gameColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex != 4) {
                          _currentPage = Committe(changeMenuLink: changeMenu);
                          isOpened = false;
                          homeColor = _noSelectedColor;
                          eventColor = _noSelectedColor;
                          favColor = _noSelectedColor;
                          gameColor = _noSelectedColor;
                          comColor = _selectedColor;
                          schoolColor = _noSelectedColor;
                          aboutColor = _noSelectedColor;
                          currentIndex = 4;
                        }
                      });
                    },
                    child: menuItem(Icons.people, "Committee", comColor),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (currentIndex != 5) {
                            _currentPage = School(changeMenuLink: changeMenu);
                            isOpened = false;
                            homeColor = _noSelectedColor;
                            eventColor = _noSelectedColor;
                            favColor = _noSelectedColor;
                            gameColor = _noSelectedColor;
                            comColor = _selectedColor;
                            schoolColor = _noSelectedColor;
                            aboutColor = _noSelectedColor;
                            currentIndex = 5;
                          }
                        });
                      },
                      child: menuItem(Icons.school, "School", schoolColor)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (currentIndex != 6) {
                            _currentPage = About(changeMenuLink: changeMenu);
                            isOpened = false;
                            homeColor = _noSelectedColor;
                            eventColor = _noSelectedColor;
                            favColor = _noSelectedColor;
                            gameColor = _noSelectedColor;
                            comColor = _selectedColor;
                            schoolColor = _noSelectedColor;
                            aboutColor = _noSelectedColor;
                            currentIndex = 6;
                          }
                        });
                      },
                      child: menuItem(Icons.info, "About", aboutColor)),
                ],
              )
            ],
          ),
        ), // ignore: argument_type_not_assignabl
      ),
    );
  }

  Widget thePage() {
    return AnimatedPositioned(
      duration: _animatedDuration,
      top: 0,
      bottom: 0,
      left: isOpened ? MediaQuery.of(context).size.width * 0.5 : 0,
      right: isOpened ? MediaQuery.of(context).size.width * (-0.5) : 0,
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: _currentPage),
    );
  }

  Widget menuItem(icon, title, theColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      margin: EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
          color: theColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white54,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 17, color: Colors.white),
          )
        ],
      ),
    );
  }
}
