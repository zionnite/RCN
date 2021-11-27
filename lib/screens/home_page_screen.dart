import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:rcn/controller/itinerary_controller.dart';
import 'package:rcn/controller/seek_god_controller.dart';
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

  late ScrollController _controller;
  late ScrollController _xcontroller;

  var current_page = 1;
  var xcurrent_page = 1;
  bool isLoading = false;
  bool isxLoading = false;
  bool widgetLoading = true;
  bool widgetxLoading = true;

  getIfSeekerLoaded() {
    var loading = seekerController.isDataProcessing.value;
    if (loading) {
      setState(() {
        widgetxLoading = false;
      });
    }
  }

  getIfItineryLoaded() {
    var loading = itineraryController.isDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    itineraryController.getItineray();
    seekerController.getSeekGod();
    _controller = ScrollController()..addListener(_scrollListener);
    _xcontroller = ScrollController()..addListener(_xscrollListener);

    Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        getIfSeekerLoaded();
        getIfItineryLoaded();
      });
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      itineraryController.getItinerarMore(current_page);

      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _xscrollListener() {
    if (_xcontroller.position.pixels == _xcontroller.position.maxScrollExtent) {
      setState(() {
        isxLoading = true;
        xcurrent_page++;
      });

      seekerController.getSeekGodMore(xcurrent_page);

      Future.delayed(new Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            isxLoading = false;
          });
        }
      });
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      isLoading = true;
      current_page = 1;
    });

    itineraryController.itinearyList.clear();
    itineraryController.getItinerarMore(current_page);

    Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> handlexRefresh() async {
    setState(() {
      isxLoading = true;
      xcurrent_page = 1;
    });

    seekerController.seekGodList.clear();
    seekerController.getSeekGodMore(xcurrent_page);

    Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        isxLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorDark,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
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
                        Image.asset(
                          'assets/images/rcn_logo.png',
                          width: 90,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                        // CircleAvatar(
                        //   radius: 30,
                        //   backgroundColor: Colors.deepOrange,
                        //   child: CircleAvatar(
                        //     radius: 29.5,
                        //     backgroundImage: AssetImage(
                        //       'assets/images/rcn_logo.png',
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 3,
                        // ),
                        // Text(
                        //   'RCN Global',
                        //   style: GoogleFonts.lancelot(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
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
                        'Apostle\'s Teaching (Note)',
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
                        child: (widgetxLoading)
                            ? Center(
                                child: Loading(
                                  indicator: BallPulseIndicator(),
                                  size: 50.0,
                                  color: Colors.redAccent,
                                ),
                              )
                            : Obx(
                                () => ListView.builder(
                                  controller: _xcontroller,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      seekerController.seekGodList.length,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                            seekerController
                                                    .seekGodList.length -
                                                1 &&
                                        isxLoading == true) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (seekerController
                                            .seekGodList[index].id ==
                                        null) {
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
                                        seek_img: seekerController
                                            .seekGodList[index].image,
                                        seek_body: seekerController
                                            .seekGodList[index].desc,
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
                        'Upcoming Apostle\'s Itinerary',
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
                      child: (widgetLoading)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Loading(
                                  indicator: BallGridPulseIndicator(),
                                  size: 50.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                            )
                          : Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    itineraryController.itinearyList.length,
                                itemBuilder: (context, index) {
                                  if (index ==
                                          itineraryController
                                                  .itinearyList.length -
                                              1 &&
                                      isLoading == true) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (itineraryController
                                          .itinearyList[index].id ==
                                      null) {
                                    itineraryController
                                        .isMoreDataAvailable.value = false;

                                    return Container();
                                  }
                                  if (itineraryController
                                              .itinearyList[index].id ==
                                          null &&
                                      (itineraryController
                                                  .itinearyList[index].status ==
                                              "end 1" ||
                                          itineraryController
                                                  .itinearyList[index].status ==
                                              "end 2")) {
                                    false;

                                    return Text('Empty');
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
