import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: SizedBox(
          height: 200.0,
          width: double.infinity,
          child: Carousel(
            images: [
              NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
            ],
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.lightGreenAccent,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.purple.withOpacity(0.5),
            borderRadius: true,
          )),
    );
  }
}
