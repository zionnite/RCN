import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/notifiers/play_button_notifier.dart';
import 'package:rcn/notifiers/progress_notifier.dart';
import 'package:rcn/notifiers/repeat_button_notifier.dart';
import 'package:rcn/services/service_locator.dart';

class MessagePlayer extends StatefulWidget {
  MessagePlayer(
      {required this.id,
      required this.title,
      required this.album,
      required this.url,
      required this.artUri});
  String id;
  String title;
  String album;
  String url;
  String artUri;

  @override
  _MessagePlayerState createState() => _MessagePlayerState();
}

class _MessagePlayerState extends State<MessagePlayer> {
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
                // Positioned(
                //   bottom: 40,
                //   child: Column(
                //     children: [
                //       Container(
                //         padding: EdgeInsets.symmetric(horizontal: 10),
                //         child: CurrentSongTitle(),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AudioProgressBar(),
            ),
            Container(
              child: AudioControlButtons(),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print('Download Tap');
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
                    onTap: () {
                      print('Playlist Tap');
                    },
                    child: Card(
                      color: Colors.green,
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
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
            )
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
