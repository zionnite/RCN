import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcn/model/itinerary_model.dart';

class UpcomingItenaryScreen extends StatefulWidget {
  UpcomingItenaryScreen({Key? key, required this.itineraryList})
      : super(key: key);

  Itinerary itineraryList;
  @override
  _UpcomingItenaryScreenState createState() => _UpcomingItenaryScreenState();
}

class _UpcomingItenaryScreenState extends State<UpcomingItenaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.itineraryList.image,
                height: 450,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  left: 10,
                  right: 10,
                ),
                child: Text(
                  widget.itineraryList.title,
                  style: GoogleFonts.lancelot(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Event Set Date'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range_rounded,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '${widget.itineraryList.eventDate}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Event Start-Time'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('${widget.itineraryList.eventDate}'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: Text(
                  widget.itineraryList.desc,
                  style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
