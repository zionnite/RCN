import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/notifiers/play_button_notifier.dart';
import 'package:rcn/notifiers/progress_notifier.dart';
import 'package:rcn/notifiers/repeat_button_notifier.dart';
import 'package:rcn/services/service_locator.dart';

class YourAudioPlaylist extends StatefulWidget {
  const YourAudioPlaylist({Key? key}) : super(key: key);

  @override
  _YourAudioPlaylistState createState() => _YourAudioPlaylistState();
}

class _YourAudioPlaylistState extends State<YourAudioPlaylist> {
  @override
  Widget build(BuildContext context) {
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
            Playlist(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    playMyAudioPlaylist();
  }
}

playMyAudioPlaylist() {
  final pageManager = getIt<PageManager>();
  pageManager.loadMyAudioPlaylist();
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
            height: 400,
          );
        if (imageLink == null)
          return Image.asset(
            'assets/images/apostle.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 400,
          );

        return SizedBox(
          height: 400,
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
                    color: Colors.black.withOpacity(0.3),
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
                InkWell(
                  onTap: () {
                    var current_id = pageManager.getCurrentSongId();
                    var current_playlist = pageManager.getCurrentPlaylist();
                    pageManager.skipToQueueItem(index, playlistTitles[index]);
                    // pageManager.updateMyQueueItem(
                    //   current_playlist[int.parse(current_id)],
                    //   int.parse(current_id),
                    // );
                  },
                  child: ListTile(
                    //leading: CurrentSongImage(),
                    title: Text(
                      '${playlistTitles[index]}',
                    ),
                    //trailing: AddRemoveSongButtons(),
                  ),
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
