import 'package:flutter/material.dart';
import 'package:rcn/screens/event_page.dart';
import 'package:rcn/screens/home_page.dart';
import 'package:rcn/screens/message_player.dart';
import 'package:rcn/screens/music_message_player.dart';
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
    EventPage(),
    MessagePlayer(),
    MusicMessagePlayer(),
    MusicMessagePlayer(),
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

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Give"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.music_note_outlined),
            title: Text("Message"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.menu_book_sharp),
            title: Text("Books"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.video_call_sharp),
            title: Text("Live"),
            selectedColor: bgColorWhite,
            unselectedColor: primaryColorLight,
          ),
        ],
      ),
    );
  }
}
