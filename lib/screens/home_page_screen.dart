import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  late String _localPath;
  bool downloading = false;
  var progressString = "";
  double progress = 0.0;

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

            InkWell(
              onTap: () async {
                _prepare();
                String url =
                    "https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3";
                //downloadFile(url);
              },
              child: (downloading)
                  ? LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                    )
                  : Card(
                      child: Text(
                        'Hello Click',
                      ),
                    ),
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

  _prepare() async {
    // final status = await Permission.storage.request();
    final status = (Platform.isAndroid)
        ? await Permission.storage.request()
        : await Permission.photos.request();

    print(status);
    if (status.isGranted) {
      await _prepareSaveDir();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> downloadFile(String url) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(url, "${_localPath}/myimage.mp3",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          progress = rec / total;
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
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
