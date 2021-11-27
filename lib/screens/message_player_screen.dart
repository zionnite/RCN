import 'dart:io';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/controller/audio_msg_controller.dart';
import 'package:rcn/notifiers/play_button_notifier.dart';
import 'package:rcn/notifiers/progress_notifier.dart';
import 'package:rcn/notifiers/repeat_button_notifier.dart';
import 'package:rcn/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePlayer extends StatefulWidget {
  MessagePlayer({
    required this.id,
    required this.title,
    required this.album,
    required this.url,
    required this.artUri,
    required this.isPlayListed,
    required this.user_id,
  });
  String id;
  String title;
  String album;
  String url;
  String artUri;
  bool isPlayListed;
  String user_id;

  @override
  _MessagePlayerState createState() => _MessagePlayerState();
}

class _MessagePlayerState extends State<MessagePlayer> {
  final audioMsgListController = AudioMsgController().getXID;

  late String _localPath;
  bool downloading = false;
  var progressString = "";
  double progress = 0.0;
  var totalSize;
  bool? isDownloadWarningStatus;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isDownloadWarning = prefs.getBool('isDownloadWarningStatus');
    setState(() {
      isDownloadWarningStatus = isDownloadWarning;
    });
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
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          progress = rec / total;
          totalSize = (total / 100).toStringAsFixed(0);
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

  @override
  void initState() {
    super.initState();
    // getIt<PageManager>().init();
    addMessageToPlayer(
      id: widget.id,
      title: widget.title,
      album: widget.album,
      url: widget.url,
      artUri: widget.artUri,
    );

    _initUserDetail();
  }

  @override
  void dispose() {
    // getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: NestedScrollView(
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           expandedHeight: 600.0,
    //           floating: false,
    //           pinned: true,
    //           flexibleSpace: FlexibleSpaceBar(
    //             centerTitle: true,
    //             title: CurrentSongTitle(),
    //             background: CurrentSongImage(),
    //           ),
    //         ),
    //       ];
    //     },
    //     body: Column(
    //       children: [
    //         // AddRemoveSongButtons(),
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Column(
    //               children: [
    //                 AudioProgressBar(),
    //                 AudioControlButtons(),
    //                 Expanded(
    //                   child: Playlist(),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CurrentSongImage(),
                Positioned(
                  top: 30,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.deepOrange,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AudioProgressBar(),
            ),
            Container(
              child: AudioControlButtons(),
            ),
            (isDownloadWarningStatus == null)
                ? Container(
                    //height: 10,
                    color: Colors.yellowAccent,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                                'Don\'t navigate from this page during download')),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isDownloadWarningStatus', true);
                            setState(() {
                              isDownloadWarningStatus = true;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (downloading == false) {
                        setState(() {
                          downloading = true;
                        });
                        await _prepare();
                        downloadFile(widget.url, widget.title);

                        if (downloading == true) {
                          showSnackBar("Downloading",
                              "Audio Message is downloading...", Colors.black);
                        } else if (downloading == false) {
                          showSnackBar(
                              "Download Completed",
                              "Audio Message has been saved into your device, enjoy!...",
                              Colors.black);
                        }
                      } else {
                        showSnackBar(
                            "Wait", "Download is in Progress...", Colors.black);
                      }
                    },
                    child: Card(
                      color: Colors.deepOrange,
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Download',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var toggle = await audioMsgListController.toggle_playlist(
                          widget.user_id, widget.id);

                      if (toggle == 'added') {
                        setState(() {
                          widget.isPlayListed = true;
                        });
                      } else if (toggle == 'deleted') {
                        setState(() {
                          widget.isPlayListed = false;
                        });
                      }
                    },
                    child: Card(
                      color: (widget.isPlayListed) ? Colors.red : Colors.green,
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            (widget.isPlayListed)
                                ? Text(
                                    'Remove from Playlist',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Add to Playlist',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.audiotrack,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (downloading)
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 8.0),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${progressString}'),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

void itemlist() {
  AddRemoveSongButtons();
  CurrentSongTitle();
  CurrentSongImage();
  AudioProgressBar();
  AudioControlButtons();
  Playlist();
}

class CurrentSongImage extends StatelessWidget {
  const CurrentSongImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongImageNotifier,
      builder: (_, imageLink, __) {
        if (imageLink.isEmpty)
          return Image.asset(
            'assets/images/apostle.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 600,
          );
        if (imageLink == null)
          return Image.asset(
            'assets/images/apostle.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 600,
          );
        return SizedBox(
          height: 600,
          child: Stack(
            children: [
              Image.network(
                '${imageLink}',
                width: double.infinity,
                height: 600,
                fit: BoxFit.cover,
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.grey.withOpacity(0),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: CurrentSongTitle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<List<String>>(
      valueListenable: pageManager.playlistNotifier,
      builder: (context, playlistTitles, _) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: playlistTitles.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  //leading: CurrentSongImage(),
                  title: Text(
                    '${playlistTitles[index]}',
                  ),
                  //trailing: AddRemoveSongButtons(),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            );
          },
        );
      },
    );
  }
}

addMessageToPlayer({
  required String id,
  required String title,
  required String album,
  required String url,
  required String artUri,
}) {
  final pageManager = getIt<PageManager>();
  pageManager.addMessageToPlayer(
    id: id,
    title: title,
    album: album,
    url: url,
    artUri: artUri,
  );
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: pageManager.add,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: pageManager.remove,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return Container(
              child: IconButton(
                icon: Icon(Icons.pause),
                iconSize: 32.0,
                onPressed: pageManager.pause,
              ),
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
