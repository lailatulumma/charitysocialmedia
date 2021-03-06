import 'package:emphaty/src/komunitas/home.dart';
import 'package:emphaty/src/komunitas/profile.dart';
import 'package:emphaty/src/komunitas/upload.dart';
import 'package:emphaty/src/komunitas/notification.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  int currentTabIndex = 0; 

  List<Widget> pages;
  Widget currentPage;

  Home homePage;
  Upload uploadPage;
  NotificationCommunity notificationPage;
  Profile profilePage;

  get user => null;

  

  @override
  void initState() {
    super.initState();
    homePage = Home();
    uploadPage = Upload();
    notificationPage = NotificationCommunity();
    profilePage = Profile();
    pages = [homePage, uploadPage, notificationPage, profilePage];

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text("Upload"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
