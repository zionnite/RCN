import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcn/component/home_banner.dart';
import 'package:rcn/component/study_with_apostle.dart';
import 'package:rcn/component/upcoming_event_card.dart';
import 'package:rcn/screens/read_daily_screen.dart';
import 'package:rcn/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 45.0,
            // ),
            Stack(
              children: [
                // Icon(
                //   Icons.menu,
                //   color: Colors.white,
                // ),

                Container(
                  margin: EdgeInsets.only(top: 00.0),
                  child: HomeBanner(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 10,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepOrange,
                        child: CircleAvatar(
                          radius: 29.5,
                          backgroundImage: AssetImage(
                            'assets/images/rcn.jpeg',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'RCN Global',
                        style: GoogleFonts.lancelot(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Material(
              // elevation: 10,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 35.0,
                  bottom: 30,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 9,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seek God in His Word every day',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: fadeColorBlack,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15.0,
                      ),
                      height: 200.0,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,

                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Get.to(
                                ReadScriptureDaily(),
                              );
                            },
                            child: StudyWithApostle(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                ReadScriptureDaily(),
                              );
                            },
                            child: StudyWithApostle(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                ReadScriptureDaily(),
                              );
                            },
                            child: StudyWithApostle(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                ReadScriptureDaily(),
                              );
                            },
                            child: StudyWithApostle(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                ReadScriptureDaily(),
                              );
                            },
                            child: StudyWithApostle(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Events

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 0,
                    ),
                    child: Text(
                      'Upcoming Apostle\'s Itenary',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: fadeColorBlack,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 0,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        UpComingEventCard(),
                        UpComingEventCard(),
                        UpComingEventCard(),
                        UpComingEventCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
