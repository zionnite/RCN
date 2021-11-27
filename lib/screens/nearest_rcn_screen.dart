import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rcn/controller/nearest_rcn_controller.dart';
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

  final nearController = NearestRcnController().getXID;

  late ScrollController _controller;
  var current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nearController.getData();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      nearController.getDataMore(current_page);

      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

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
        controller: _controller,
        child: Card(
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: nearController.nearList.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == nearController.nearList.length - 1 &&
                    isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (nearController.nearList[index].id == null) {
                  nearController.isMoreDataAvailable.value = false;
                  return Container();
                }
                return NearestRcnWidget(
                  nearest_title: nearController.nearList[index].title,
                  nearest_point_man: nearController.nearList[index].pointMan,
                  neearest_location: nearController.nearList[index].location,
                  nearest_phone_no: nearController.nearList[index].phoneNo,
                  nearest_website: nearController.nearList[index].website,
                  nearest_lat: nearController.nearList[index].lat,
                  nearest_lon: nearController.nearList[index].lon,
                  isLatLon: nearController.nearList[index].isLatLon,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
