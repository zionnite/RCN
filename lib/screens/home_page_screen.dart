import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcn/controller/itinerary_controller.dart';
import 'package:rcn/controller/seek_god_controller.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/screens/read_daily_screen.dart';
import 'package:rcn/util.dart';
import 'package:rcn/widget/home_banner.dart';
import 'package:rcn/widget/study_with_apostle.dart';
import 'package:rcn/widget/upcoming_event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final seekerController = SeekGodController().getXID;
  final itineraryController = ItineraryController().getXID;

  var seekerList = <SeeKGod>[];

  @override
  void initState() {
    super.initState();
    // _prepare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorDark,
      body: SingleChildScrollView(
        controller: itineraryController.itineraryScrollController,
        child: Column(
          children: [
            // SizedBox(
            //   height: 45.0,
            // ),
            Stack(
              children: [
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
                      child: Obx(
                        () => ListView.builder(
                          controller: seekerController.scrollController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: seekerController.seekGodList.length,
                          itemBuilder: (context, index) {
                            if (index ==
                                    seekerController.seekGodList.length - 1 &&
                                seekerController.isMoreDataAvailable.value ==
                                    true) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (seekerController.seekGodList[index].id ==
                                null) {
                              seekerController.isMoreDataAvailable.value =
                                  false;
                              return Container();
                            }

                            return InkWell(
                              onTap: () {
                                Get.to(
                                  ReadScriptureDaily(
                                    desc: seekerController
                                        .seekGodList[index].desc,
                                    image: seekerController
                                        .seekGodList[index].image,
                                    title: seekerController
                                        .seekGodList[index].title,
                                  ),
                                );
                              },
                              child: StudyWithApostle(
                                seek_img:
                                    seekerController.seekGodList[index].image,
                                seek_body:
                                    seekerController.seekGodList[index].desc,
                              ),
                            );
                          },
                        ),
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
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: itineraryController.itinearyList.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  itineraryController.itinearyList.length - 1 &&
                              itineraryController.isMoreDataAvailable.value ==
                                  true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (itineraryController.itinearyList[index].id ==
                              null) {
                            itineraryController.isMoreDataAvailable.value =
                                false;
                            return Container();
                          }
                          return UpComingEventCard(
                            itineraryList:
                                itineraryController.itinearyList[index],
                          );
                        },
                      ),
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

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
    );
  }
}
