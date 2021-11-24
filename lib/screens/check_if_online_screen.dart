import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/controller/live_message_controller.dart';
import 'package:rcn/screens/video_message_screen.dart';
import 'package:rcn/util.dart';

import 'live_meessage_screen.dart';

class CheckIfOnlineScreen extends StatefulWidget {
  const CheckIfOnlineScreen({Key? key}) : super(key: key);

  @override
  _CheckIfOnlineScreenState createState() => _CheckIfOnlineScreenState();
}

class _CheckIfOnlineScreenState extends State<CheckIfOnlineScreen> {
  final liveMessController = LiveMessageController().getXID;

  var isLiveNow;
  bool isLoading = true;
  String? Ylink;

  get_live_status() async {
    var status = await liveMessController.getLiveStatus();
    var link = await liveMessController.getLiveLink();
    setState(() {
      if (status == 'true') {
        isLiveNow = true;
        Ylink = link;
      } else {
        isLiveNow = false;
        Ylink = null;
      }

      isLoading = false;
    });
  }

  Future<void> handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    get_live_status();
  }

  @override
  void initState() {
    super.initState();
    get_live_status();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Loading...'),
                ],
              ),
            )
          : (!isLiveNow)
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.redAccent,
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          //margin: EdgeInsets.only(top: 110),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 40,
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Remnant Christian Network',
                                          style: TextStyle(
                                            // color: primaryTextColor,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 80.0, right: 80),
                                          child: Divider(
                                            height: 5.0,
                                            // color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Striving for the rebirth of apostolic christianity...',
                                          style: TextStyle(
                                            // color: primaryTextColor,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/apostle.jpeg',
                                        width: double.infinity,
                                        height: 300.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 60.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                          ),
                                          height: 200.0,
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  top: 45.0,
                                                ),
                                                child: Text(
                                                  'We',
                                                  style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: textColorBlack,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  'Are',
                                                  style: TextStyle(
                                                    fontSize: 48.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: textColorRed,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  'Offline',
                                                  style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: textColorBlack,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'We are offline at the moment, watch video on demand by clicking the button below',
                                            style: TextStyle(
                                              // color: primaryTextColor,
                                              fontSize: 18.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => VideoMessage(),
                                          transition: Transition.upToDown,
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: primaryColorLight,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color: Colors.redAccent,
                                        elevation: 5,
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Text(
                                              'Watch Video On Demand',
                                              style: TextStyle(
                                                color: textColorWhite,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : (isLiveNow == true && Ylink!.length > 10)
                  ? Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.redAccent,
                        elevation: 0,
                      ),
                      body: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              //margin: EdgeInsets.only(top: 110),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    bottom: 40,
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Remnant Christian Network',
                                              style: TextStyle(
                                                // color: primaryTextColor,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80.0, right: 80),
                                              child: Divider(
                                                height: 5.0,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Striving for the rebirth of apostolic christianity...',
                                              style: TextStyle(
                                                // color: primaryTextColor,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/apostle.jpeg',
                                            width: double.infinity,
                                            height: 300.0,
                                            fit: BoxFit.cover,
                                          ),
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 60.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.white.withOpacity(1),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              height: 200.0,
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                      top: 45.0,
                                                    ),
                                                    child: Text(
                                                      'We',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                    ),
                                                    child: Text(
                                                      'Are',
                                                      style: TextStyle(
                                                        fontSize: 48.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorRed,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                    ),
                                                    child: Text(
                                                      'Live',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Click the button below, to get redirected to Live Streaming!',
                                                style: TextStyle(
                                                  // color: primaryTextColor,
                                                  fontSize: 18.0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => LiveMessage(),
                                            );
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: primaryColorLight,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.redAccent,
                                            elevation: 5,
                                            child: Container(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                    color: textColorWhite,
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.redAccent,
                        elevation: 0,
                      ),
                      body: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              //margin: EdgeInsets.only(top: 110),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    bottom: 40,
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Remnant Christian Network',
                                              style: TextStyle(
                                                // color: primaryTextColor,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 80.0, right: 80),
                                              child: Divider(
                                                height: 5.0,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Striving for the rebirth of apostolic christianity...',
                                              style: TextStyle(
                                                // color: primaryTextColor,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/apostle.jpeg',
                                            width: double.infinity,
                                            height: 300.0,
                                            fit: BoxFit.cover,
                                          ),
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 60.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.white.withOpacity(1),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              height: 200.0,
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                      top: 45.0,
                                                    ),
                                                    child: Text(
                                                      'We',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                    ),
                                                    child: Text(
                                                      'Are',
                                                      style: TextStyle(
                                                        fontSize: 48.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorRed,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5.0,
                                                    ),
                                                    child: Text(
                                                      'Online',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: textColorBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'We are Online, something happened, please click the button below to refresh the page',
                                                style: TextStyle(
                                                  // color: primaryTextColor,
                                                  fontSize: 18.0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            handleRefresh();
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: primaryColorLight,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.redAccent,
                                            elevation: 5,
                                            child: Container(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  'Refresh Now',
                                                  style: TextStyle(
                                                    color: textColorWhite,
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
    );
  }
  //islive == true but Ylink == null (show reload page)
  //else show

  goToLiveScreenPage(var link) {
    Get.to(
      () => LiveMessage(),
    );

    // print('comming here');
  }
}
