import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rcn/model/player_model.dart';

class PlayerController extends GetxController {
  PlayerController get getXID => Get.find<PlayerController>();

  var playerList = <PlayerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  setPlayerList(List<PlayerModel> player) {
    playerList.assignAll(player);
  }

  addPlayerList(PlayerModel playerModel) {
    playerList.add(playerModel);
  }

  loopPlayerListApi() {
    for (var i = 0; i < playerList.length; i++) {
      return AudioSource.uri(
        Uri.parse(
          "${playerList[i].audioUrl}",
        ),
        tag: MediaItem(
          id: '${playerList[i].id}',
          album: "${playerList[i].album}",
          title: "${playerList[i].title}",
          artUri: Uri.parse(
            "${playerList[i].artUri}",
          ),
        ),
      );
    }
  }
}
