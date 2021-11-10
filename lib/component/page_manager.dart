import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:rcn/notifiers/play_button_notifier.dart';
import 'package:rcn/notifiers/progress_notifier.dart';
import 'package:rcn/notifiers/repeat_button_notifier.dart';
import 'package:rcn/services/playlist_repository.dart';
import 'package:rcn/services/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class PageManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final currentSongImageNotifier = ValueNotifier<String>('');
  final currentSongIDNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();
  var newPlayList;

  // Events: Calls coming from the UI
  void init() async {
    // await _loadPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    _listenToChangesInPlaylist();
  }

  Future<void> _loadPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();

    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              artUri: Uri.parse(song['artUri'] ?? ''),
              extras: {'url': song['url']},
            ))
        .toList();

    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> loadMyAudioPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();

    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              artUri: Uri.parse(song['artUri'] ?? ''),
              extras: {'url': song['url']},
            ))
        .toList();

    //_audioHandler.removeAllQueueItem();
    _audioHandler.addQueueItems(mediaItems);
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
        currentSongImageNotifier.value = '';
        currentSongIDNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toList();
        playlistNotifier.value = newList;

        newPlayList = playlist.map((item) => item).toList();
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    var artistUrl;
    _audioHandler.mediaItem.listen(
      (mediaItem) {
        currentSongTitleNotifier.value = mediaItem?.title ?? '';
        artistUrl = mediaItem?.artUri;
        currentSongImageNotifier.value = artistUrl.toString();
        currentSongIDNotifier.value = mediaItem?.id ?? '';

        _updateSkipButtons();
      },
    );
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist!.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() {
    _audioHandler.play();
  }

  void pause() {
    _audioHandler.pause();
  }

  getCurrentSongId() {
    return currentSongIDNotifier.value;
  }

  getCurrentPlaylist() {
    return newPlayList;
  }

  void skipToQueueItem(int index, String name) {
    _audioHandler.skipToQueueItem(index);
  }

  // void updateMyQueueItem(MediaItem mediaItem, int index) {
  //   print('Song List Number Click ${mediaItem}');
  //   print('Song List Number Click ${index}');
  //   _audioHandler.updateMediaItem(mediaItem);
  // }

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> add() async {
    final songRepository = getIt<PlaylistRepository>();
    final song = await songRepository.fetchAnotherSong();
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      title: song['title'] ?? '',
      album: song['album'] ?? '',
      extras: {
        'url': song['url'],
        'artUri': song['artUri'],
      },
    );
    _audioHandler.addQueueItem(mediaItem);
  }

  addMessageToPlayer(
      {required String id,
      required String title,
      required String album,
      required String url,
      required String artUri}) {
    // print('ID came ${id}');
    // print('TITLE came ${title}');
    // print('ALBUM came ${album}');
    // print('URL came ${url}');
    // print('ARTURL came ${artUri}');

    final mediaItem = MediaItem(
      id: id,
      title: title,
      album: album,
      artUri: Uri.parse(artUri),
      extras: {
        'url': url,
      },
    );

    _audioHandler.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value!.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
