import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/screens/message_player_screen.dart';

class ListMessageWidget extends StatefulWidget {
  ListMessageWidget({
    Key? key,
    required this.aud_image,
    required this.aud_link,
    required this.aud_title,
    required this.aud_id,
    required this.aud_album,
  }) : super(key: key);
  String aud_image;
  String aud_link;
  String aud_title;
  String aud_id;
  String aud_album;

  @override
  _ListMessageWidgetState createState() => _ListMessageWidgetState();
}

class _ListMessageWidgetState extends State<ListMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: ListTile(
        leading: Image.network(
          '${widget.aud_image}',
          fit: BoxFit.cover,
          width: 50,
          height: 150,
        ),
        title: Text(
          '${widget.aud_title}',
        ),
        trailing: PopupMenuButton(
          enabled: true,
          onSelected: (value) {
            if (value == 'play') {
              Get.to(
                () => MessagePlayer(
                  id: '${widget.aud_id}',
                  title: '${widget.aud_title}',
                  album: '${widget.aud_album}',
                  url: '${widget.aud_link}',
                  artUri: '${widget.aud_image}',
                ),
              );
            }
            setState(() {
              //_value = value;
              //print(_value);
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Play"),
              value: "play",
            ),
            PopupMenuItem(
              child: Text("Download"),
              value: "Download",
            ),
            PopupMenuItem(
              child: Text("Add to Playlist"),
              value: "Add to Playlist",
            ),
          ],
        ),
      ),
    );
  }
}
