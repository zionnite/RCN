import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class NearestRcnWidget extends StatefulWidget {
  NearestRcnWidget(
      {Key? key,
      required this.nearest_title,
      required this.nearest_point_man,
      required this.neearest_location,
      required this.nearest_phone_no,
      required this.nearest_website,
      required this.nearest_lat,
      required this.nearest_lon,
      required this.isLatLon})
      : super(key: key);

  String nearest_title;
  String nearest_point_man;
  String neearest_location;
  String nearest_phone_no;
  String nearest_website;
  String nearest_lat;
  String nearest_lon;
  bool isLatLon;

  @override
  _NearestRcnWidgetState createState() => _NearestRcnWidgetState();
}

class _NearestRcnWidgetState extends State<NearestRcnWidget> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  String _phone = '09034286339';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ExpansionTileCard(
        key: cardA,
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          radius: 30,
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/rcn.jpeg',
            ),
            radius: 27.5,
          ),
        ),
        title: Text('${widget.nearest_title}'),
        subtitle: Text('Point-Man ${widget.nearest_point_man}'),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.neearest_location}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.redAccent),
                  ),
                  Text(
                    '${widget.nearest_phone_no}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'WebSite',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.redAccent),
                  ),
                  Text(
                    '${widget.nearest_website}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                style: flatButtonStyle,
                onPressed: () async {
                  _makePhoneCall('tel:${widget.nearest_phone_no}',
                      widget.nearest_phone_no);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.call),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Call'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  _launchWebsite(widget.nearest_website);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.sports_soccer_sharp),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Visit Website'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  (widget.isLatLon)
                      ? MapsLauncher.launchCoordinates(
                          double.parse(widget.nearest_lat),
                          double.parse(widget.nearest_lon))
                      : _lunchMapQuery(widget.neearest_location);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.location_on_sharp),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('View on Map'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url, String phone) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //throw 'Could not launch $url';
      Get.snackbar(
        'Oops',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _launchWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      Get.snackbar(
        'Oops',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _lunchMapQuery(String location) {
    MapsLauncher.launchQuery('${location}');
  }

  _lunchMapCord(double lat, double lon, String nearest_title) {
    MapsLauncher.launchCoordinates(lat, lon, '${nearest_title}');
  }
}
