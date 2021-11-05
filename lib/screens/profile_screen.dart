import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        color: Colors.grey.withOpacity(0.2),
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
                        onPressed: () => Get.back(),
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
                      'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
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
                  ListTile(
                    leading: Icon(Icons.audiotrack),
                    title: Text('Audio Playlist'),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.redAccent,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.video_collection_rounded),
                    title: Text('Video Playlist'),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.redAccent,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('Offering/Tithe Insight'),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.redAccent,
                    ),
                  ),
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
                            'Nosakhare',
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
                            'Nosakhare Atekha Endurance Zionnite',
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
                            '09034286339',
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
                            '14yrs',
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
                  //logoutUser();
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
}
