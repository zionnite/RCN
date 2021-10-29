import 'package:flutter/material.dart';
import 'package:rcn/component/home_banner.dart';
import 'package:rcn/component/upcoming_event_card.dart';
import 'package:rcn/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorDark,
        body: SingleChildScrollView(
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
                ],
              ), //Start Status for the Day
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 35.0,
                  horizontal: 15,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 15,
                ),
                color: primaryColor,
                width: double.infinity,
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seek God in His Word every day',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15.0,
                      ),
                      height: 180.0,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,

                        children: <Widget>[
                          Container(
                            width: 260.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg',
                                  //height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Learning from the persecuted Church',
                                      style: TextStyle(
                                        color: primaryTextColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.green,
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.yellow,
                          ),
                          Container(
                            width: 160.0,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
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
                          horizontal: 12.0, vertical: 0),
                      child: Text(
                        'Upcoming Apostle\'s Itenary',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: primaryTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
              // Container(
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(
              //           bottom: 5.0,
              //           top: 5.0,
              //         ),
              //         child: Text(
              //           'Upcoming Apostle\'s Itenary',
              //           style: TextStyle(
              //             fontSize: 20.0,
              //             color: primaryTextColor,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //       ListView(
              //         physics: ClampingScrollPhysics(),
              //         scrollDirection: Axis.vertical,
              //         shrinkWrap: true,
              //         children: <Widget>[
              //           Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 10,
              //             ),
              //             child: Container(
              //               child: Card(
              //                 elevation: 15.0,
              //                 color: primaryColor,
              //                 semanticContainer: true,
              //                 clipBehavior: Clip.antiAliasWithSaveLayer,
              //                 shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                     color: primaryColorLight,
              //                     width: 1,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.network(
              //                       'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg',
              //                       //height: 150,
              //                       width: double.infinity,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text(
              //                         'Learning from the persecuted Chukj nhnjknjkjkhihuihiuohuhuihuihouhuihuiohuih uihuih ui hiuohohuoihoiuhuoih ouihouihuihuihuihuih uihuhrch kijji kmkldjfio iojdiiojiod iji iojiojiojio iojiiojioj jiod fijioj iijoi',
              //                         style: TextStyle(
              //                           color: primaryTextColor,
              //                           fontWeight: FontWeight.w500,
              //                           fontSize: 15.0,
              //                         ),
              //                         // overflow: TextOverflow.ellipsis,
              //                         // maxLines: 5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 10,
              //             ),
              //             child: Container(
              //               child: Card(
              //                 elevation: 15.0,
              //                 color: primaryColor,
              //                 semanticContainer: true,
              //                 clipBehavior: Clip.antiAliasWithSaveLayer,
              //                 shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                     color: primaryColorLight,
              //                     width: 1,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.network(
              //                       'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg',
              //                       //height: 150,
              //                       width: double.infinity,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text(
              //                         'Learning from the persecuted Chukj nhnjknjkjkhihuihiuohuhuihuihouhuihuiohuih uihuih ui hiuohohuoihoiuhuoih ouihouihuihuihuihuih uihuhrch kijji kmkldjfio iojdiiojiod iji iojiojiojio iojiiojioj jiod fijioj iijoi',
              //                         style: TextStyle(
              //                           color: primaryTextColor,
              //                           fontWeight: FontWeight.w500,
              //                           fontSize: 15.0,
              //                         ),
              //                         // overflow: TextOverflow.ellipsis,
              //                         // maxLines: 5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 10,
              //             ),
              //             child: Container(
              //               child: Card(
              //                 elevation: 15.0,
              //                 color: primaryColor,
              //                 semanticContainer: true,
              //                 clipBehavior: Clip.antiAliasWithSaveLayer,
              //                 shape: RoundedRectangleBorder(
              //                   side: BorderSide(
              //                     color: primaryColorLight,
              //                     width: 1,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.network(
              //                       'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg',
              //                       //height: 150,
              //                       width: double.infinity,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text(
              //                         'Learning from the persecuted Chukj nhnjknjkjkhihuihiuohuhuihuihouhuihuiohuih uihuih ui hiuohohuoihoiuhuoih ouihouihuihuihuihuih uihuhrch kijji kmkldjfio iojdiiojiod iji iojiojiojio iojiiojioj jiod fijioj iijoi',
              //                         style: TextStyle(
              //                           color: primaryTextColor,
              //                           fontWeight: FontWeight.w500,
              //                           fontSize: 15.0,
              //                         ),
              //                         // overflow: TextOverflow.ellipsis,
              //                         // maxLines: 5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
