import 'package:flutter/material.dart';

import 'custom_shape_clipper.dart';

class appTitleWidget extends StatelessWidget {
  String title;
  String toNav;
  appTitleWidget({required this.title, required this.toNav});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            PreferredSize(
              child: new Container(
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top),
                child: new Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.popAndPushNamed(context, toNav);
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                    Colors.deepOrange,
                    Colors.deepOrangeAccent,
                  ]),
                ),
              ),
              preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
            ),
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                height: 180.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange,
                      Colors.deepOrangeAccent,
                    ],
                  ),
                ),
                child: title.length < 6
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(
                          left: 20.0,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
