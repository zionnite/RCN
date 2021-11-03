import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/screens/upcoming_itenary_screen.dart';
import 'package:rcn/util.dart';

class UpComingEventCard extends StatefulWidget {
  const UpComingEventCard({Key? key}) : super(key: key);

  @override
  _UpComingEventCardState createState() => _UpComingEventCardState();
}

class _UpComingEventCardState extends State<UpComingEventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              // width: 200,
              height: 170,
              child: CachedNetworkImage(
                imageUrl:
                    "https://rcnauchi.com/other_img/greetings/b95e23dcebabc991a85b52bb62287300.jpeg",
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
                placeholder: (context, progressText) => Center(
                  child: CircularProgressIndicator(
                    value: 0.8,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Apostolic Invasion - Uganda',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textColorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Apostle will  becoming to Uganda under mandate of Heaven, save the date and dont miss it for anything',
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              UpcomingItenaryScreen(),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                  color: textColorBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
