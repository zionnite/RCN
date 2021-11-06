import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:rcn/widget/nearest_rcn_widget.dart';

class NearestRcnScreen extends StatefulWidget {
  NearestRcnScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;
  @override
  _NearestRcnScreenState createState() => _NearestRcnScreenState();
}

class _NearestRcnScreenState extends State<NearestRcnScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        // elevation: 0,
        title: Text(
          'Nearest RCN',
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              NearestRcnWidget(
                nearest_title: 'RCN Auchi',
                nearest_point_man: 'Rev Stanley',
                neearest_location:
                    '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
                nearest_phone_no: '+2348034323343',
                nearest_website: 'https://www.rcnauchi.com',
                nearest_lat: '101192',
                nearest_lon: '8837272',
                isLatLon: false,
              ),
              NearestRcnWidget(
                nearest_title: 'RCN Auchi',
                nearest_point_man: 'Rev Stanley',
                neearest_location:
                    'Hi there, I\'m a drop-in replacement for Flutter\'s ExpansionTile.Use me any time you think your app could benefit from being just a bit more Material. These buttons control the next card down!',
                nearest_phone_no: '0800-34323-343',
                nearest_website: 'www.rcnauchi.com',
                nearest_lat: '101192',
                nearest_lon: '8837272',
                isLatLon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
