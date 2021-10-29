import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                children: [
                  Text(
                    'Apostle Invasion - Uganda',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: textColorBlack,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Apostle will  becoming to Uganda under mandate of Heaven, save the date and dont miss it for anything',
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: InkWell(
                          onTap: () {
                            print('Book Event...');
                          },
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Book Event',
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
