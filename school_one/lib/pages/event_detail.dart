import 'package:better_player/better_player.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:schoolone/models/event.dart';
import 'package:schoolone/models/event_photo.dart';
import 'package:schoolone/models/event_video.dart';
import 'package:schoolone/models/student.dart';
import 'package:schoolone/pages/student_detail.dart';
import 'package:schoolone/services/firestore_service.dart';

class EventDetail extends StatefulWidget {
  Event theEvent;
  EventDetail(this.theEvent);

  @override
  State<StatefulWidget> createState() {
    return _EventDetailState(theEvent);
  }
}

class _EventDetailState extends State with SingleTickerProviderStateMixin {
  bool isSelected = true;

  FirestoreService fire = FirestoreService();
  Event theEvent;
  _EventDetailState(this.theEvent);

  Widget _videoPage = Container();

  @override
  void initState() {
    super.initState();
    isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    _videoPage = getVideoPage();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
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
                    theEvent.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  floating: true,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    indicatorWeight: 2,
                    indicatorColor: Colors.deepPurple,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.black),
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text("Photos"),
                      ),
                      Tab(
                        child: Text("Videos"),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              getImagePage(),
              _videoPage,
            ],
          ),
        )));
  }

  getImagePage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 40),
      child: StreamBuilder(
        stream: fire.getEventPhoto(theEvent.eventId),
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
    );
  }

  getVideoPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 40),
      child: StreamBuilder(
        stream: fire.getEventVideo(theEvent.eventId),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _myVideoPlayer(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }

  Widget getvideo(List<EventVideo> theVideo, int index, BuildContext context) {
    FirebaseStorage.instance
        .refFromURL(theVideo[index].video)
        .getDownloadURL()
        .then((value) {
      return _myVideoPlayer(theVideo[index]);
    });
  }

  Widget getPostItem(
      List<EventPhoto> students, int index, BuildContext context) {
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
                return StudentDetail(Student(studentId: ""));
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
              image: FirebaseImage(students[index].photo,
                  shouldCache:
                      true, // The image should be cached (default: True)
                  maxSizeBytes:
                      3000 * 1000, // 3MB max file size (default: 2.5MB)
                  cacheRefreshStrategy:
                      CacheRefreshStrategy.NEVER // Switch off update checking
                  ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  getEventItem(String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.deepOrange.shade400,
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
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
    );
  }
}

class _myVideoPlayer extends StatefulWidget {
  EventVideo thevideo;
  _myVideoPlayer(this.thevideo, {Key key}) : super(key: key);

  @override
  __myVideoPlayerState createState() => __myVideoPlayerState(this.thevideo);
}

class __myVideoPlayerState extends State<_myVideoPlayer> {
  BetterPlayerController _betterPlayerController;
  BetterPlayerConfiguration betterPlayerConfiguration;
  EventVideo thevideo;
  __myVideoPlayerState(this.thevideo);

  @override
  void initState() {
    betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        //autoDetectFullscreenDeviceOrientation: true,
        looping: true,
        fullScreenAspectRatio: 9 / 16,
        placeholder: Center(
            child: Container(
                height: 10, width: 50, child: LinearProgressIndicator())));

    getUrl(thevideo.video);
    super.initState();
  }

  void getUrl(String url) {
    FirebaseStorage.instance.refFromURL(url).getDownloadURL().then((value) {
      setState(() {
        BetterPlayerDataSource dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          value,
          cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),
        );

        _betterPlayerController =
            BetterPlayerController(betterPlayerConfiguration);

        _betterPlayerController.setupDataSource(dataSource);

        _betterPlayerController.addEventsListener((event) {
          if (event.betterPlayerEventType ==
              BetterPlayerEventType.openFullscreen) {
            betterPlayerConfiguration = BetterPlayerConfiguration(
                aspectRatio: 16 / 9,
                fit: BoxFit.contain,
                autoDetectFullscreenDeviceOrientation: true,
                looping: true,
                fullScreenAspectRatio: 9 / 16,
                rotation: 180,
                placeholder: Center(
                    child: Container(
                        height: 10,
                        width: 50,
                        child: LinearProgressIndicator())));
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: _betterPlayerController != null
          ? BetterPlayer(controller: _betterPlayerController)
          : Center(
              child: Container(width: 100, child: LinearProgressIndicator())),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
