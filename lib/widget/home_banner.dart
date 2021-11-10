import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rcn/controller/slider_controller.dart';
import 'package:rcn/model/slider.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final sliderCont = SliderController().getXID;
  var sliderList = <SliderModel>[];
  List _imgs = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   left: 15.0,
      //   right: 15.0,
      // ),
      child: SizedBox(
        height: 250.0,
        width: double.infinity,
        child: Obx(
          () {
            return loopSlider();
          },
        ),
      ),
    );
  }

  loopSlider() {
    _imgs.clear();
    for (var i = 0; i < sliderCont.sliderList.length; i++) {
      _imgs.add(
        CachedNetworkImage(
          imageUrl: sliderCont.sliderList[i].image,
          width: double.infinity,
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
      );
    }

    if (_imgs.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
      );
    }
    return Carousel(
      images: _imgs,
      dotSize: 5.0,
      dotSpacing: 10.0,
      dotColor: Colors.lightGreenAccent,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.purple.withOpacity(0.5),
      borderRadius: true,
      radius: Radius.circular(0),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
