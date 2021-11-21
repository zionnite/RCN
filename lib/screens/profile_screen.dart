import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/screens/edit_profile_screen.dart';
import 'package:rcn/screens/login_signup_screen.dart';
import 'package:rcn/screens/your_audio_playlist_screen.dart';
import 'package:rcn/screens/your_video_playlist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? user_id,
      my_email,
      my_image,
      user_img,
      full_name,
      user_name,
      age,
      phone_no;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id1 = prefs.getString('user_id');
    var user_name1 = prefs.getString('user_name');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img1 = prefs.getString('user_img');
    var user_age = prefs.getString('age');
    var phone_no1 = prefs.getString('phone_no');

    setState(() {
      user_id = user_id1!;
      user_name = user_name1!;
      full_name = user_full_name!;
      my_email = user_email!;
      user_img = user_img1!;
      age = user_age!;
      phone_no = phone_no1!;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrange,
      //   title: Text(''),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    image: DecorationImage(
                      image: AssetImage('assets/images/rcn.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 5,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.deepOrange,
                          //size: 30,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 5,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.deepOrange,
                          //size: 30,
                        ),
                        onPressed: () => Get.to(() => EditProfileScreen(),
                            transition: Transition.zoom),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 230),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      '${user_img}',
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Your Saved Data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => YourAudioPlaylist(),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.audiotrack),
                      title: Text('Audio Playlist'),
                      trailing: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => YourVideoPlaylist(),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.video_collection_rounded),
                      title: Text('Video Playlist'),
                      trailing: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(
                  //       () => YourTitheNOferringInsight(),
                  //     );
                  //   },
                  //   child: ListTile(
                  //     leading: Icon(Icons.account_balance_wallet),
                  //     title: Text('Offering/Tithe Insight'),
                  //     trailing: Icon(
                  //       Icons.chevron_right_outlined,
                  //       color: Colors.redAccent,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Your Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            'UserName',
                            style: TextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${user_name}',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            'Full Name',
                            style: TextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${full_name}',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            'Phone Number',
                            style: TextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${phone_no}',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            'Age',
                            style: TextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${age}yrs',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: InkWell(
                onTap: () {
                  logoutUser();
                },
                child: Card(
                  elevation: 4.0,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 5.0,
                      ),
                      height: 30.0,
                      width: double.infinity,
                      child: Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isUserLogin");
    //prefs?.clear();
    Get.offAll(
      () => LoginSignupScreen(),
      transition: Transition.rightToLeftWithFade,
    );
  }
}
