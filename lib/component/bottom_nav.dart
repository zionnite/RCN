import 'package:flutter/material.dart';
import 'package:rcn/screens/app_menu_option_screen.dart';
import 'package:rcn/screens/home_page_screen.dart';
import 'package:rcn/screens/live_meessage_screen.dart';
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
    AppMenuOption(),
    //MessagePlayer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryColorDark,
      body: Container(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text("Home"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.black26,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.video_call_sharp),
            title: Text("Live"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.black26,
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
            title: Text(
              "Menu",
            ),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.black54,
          ),

          /// Profile
        ],
      ),
    );
  }
}
