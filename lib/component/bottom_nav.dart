import 'package:flutter/material.dart';
import 'package:rcn/screens/LiveMessage.dart';
import 'package:rcn/screens/give_n_partner.dart';
import 'package:rcn/screens/home_page.dart';
import 'package:rcn/util.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    LiveMessage(),
    GiveAndPartner(),
    //MessagePlayer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorDark,
      body: Container(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.video_call_sharp),
            title: Text("Live"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),

          /// Likes
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.favorite_border),
          //   title: Text("Give"),
          //   selectedColor: bgColorWhite,
          //   unselectedColor: primaryColorLight,
          // ),

          /// Search
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.music_note_outlined),
          //   title: Text("Message"),
          //   selectedColor: bgColorWhite,
          //   unselectedColor: primaryColorLight,
          // ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.menu_sharp),
            title: Text("Menu"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),

          /// Profile
        ],
      ),
    );
  }
}
