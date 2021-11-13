import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rcn/controller/audio_msg_controller.dart';
import 'package:rcn/screens/message_player_screen.dart';

class ListMessageWidget extends StatefulWidget {
  ListMessageWidget({
    Key? key,
    required this.aud_image,
    required this.aud_link,
    required this.aud_title,
    required this.aud_id,
    required this.aud_album,
    required this.user_id,
    required this.isPlayListed,
  }) : super(key: key);
  String aud_image;
  String aud_link;
  String aud_title;
  String aud_id;
  String aud_album;
  String user_id;
  bool isPlayListed;

  @override
  _ListMessageWidgetState createState() => _ListMessageWidgetState();
}

class _ListMessageWidgetState extends State<ListMessageWidget> {
  final audioMsgListController = AudioMsgController().getXID;

  late String _localPath;
  bool downloading = false;
  var progressString = "";
  double progress = 0.0;

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
        subtitle: (downloading)
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                ),
              )
            : Container(),
        trailing: PopupMenuButton(
          enabled: true,
          onSelected: (value) async {
            if (value == 'Play') {
              Get.to(
                () => MessagePlayer(
                  id: '${widget.aud_id}',
                  title: '${widget.aud_title}',
                  album: '${widget.aud_album}',
                  url: '${widget.aud_link}',
                  artUri: '${widget.aud_image}',
                ),
              );
            } else if (value == 'Download') {
              setState(() {
                downloading = true;
              });
              await _prepare();
              downloadFile(widget.aud_link, widget.aud_title);

              if (downloading == true) {
                showSnackBar("Downloading", "Audio Message is downloading...",
                    Colors.black);
              } else if (downloading == false) {
                showSnackBar(
                    "Download Completed",
                    "Audio Message has been saved into your device, enjoy!...",
                    Colors.black);
              }
            } else if (value == 'Playlist') {
              var toggle = await audioMsgListController.toggle_playlist(
                  widget.user_id, widget.aud_id);

              if (toggle == 'added') {
                setState(() {
                  widget.isPlayListed = true;
                });
              } else if (toggle == 'deleted') {
                setState(() {
                  widget.isPlayListed = false;
                });
              }
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Play"),
              value: "Play",
            ),
            PopupMenuItem(
              child: Text("Download"),
              value: "Download",
            ),
            PopupMenuItem(
              child: (widget.isPlayListed)
                  ? Text('Remove from Playlist')
                  : Text("Add to Playlist"),
              value: "Playlist",
            ),
          ],
        ),
      ),
    );
  }

  _prepare() async {
    final status = await Permission.storage.request();
    // final status = (Platform.isAndroid)
    //     ? await Permission.storage.request()
    //     : await Permission.photos.request();

    // print(status);
    if (status.isGranted) {
      await _prepareSaveDir();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> downloadFile(String url, var file_name) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(url, "${_localPath}/$file_name.mp3",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          progress = rec / total;
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    showSnackBar(
      'Congratulation',
      'File Downloaded successfully',
      Colors.green,
    );
  }

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
