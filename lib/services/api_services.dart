import 'package:http/http.dart' as http;
import 'package:rcn/model/audio_msg_model.dart';
import 'package:rcn/model/itinerary_model.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/model/slider.dart';

class ApiServices {
  static var client = http.Client();
  static String _mybaseUrl = 'http://arome.joons-me.com/Api/';
  static String _sliderPath = 'get_slider';
  static String _seek_god = 'seek_god';
  static String _itinerary = 'itinerary';
  static String _audio_msg = 'audio_msg';

  static Future<List<SliderModel>?> getApiSlider() async {
    final result = await client.get(Uri.parse('$_mybaseUrl$_sliderPath'));
    if (result.statusCode == 200) {
      final slider = sliderModelFromJson(result.body);
      return slider;
    } else {
      return null;
    }
  }

  // static Future<List<SeeKGod>?> getSeekGod(var page_num) async {
  //   final result = await client.get(Uri.parse('$mybaseUrl$seek_god/$page_num'));
  //   if (result.statusCode == 200) {
  //     final slider = seeKGodFromJson(result.body);
  //     return slider;
  //   } else {
  //     return null;
  //   }
  // }

  static Future<List<SeeKGod>> getSeekGod(var page_num) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_seek_god/$page_num'));
      if (result.statusCode == 200) {
        final slider = seeKGodFromJson(result.body);
        return slider;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<Itinerary>> getItinerary(var page_num) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_itinerary/$page_num'));
      if (result.statusCode == 200) {
        final itinerary = itineraryFromJson(result.body);
        return itinerary;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<AudioMsg>> getAudioMsg(var page_num, var user_id) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_audio_msg/$page_num/$user_id'));
      if (result.statusCode == 200) {
        //print(result.body);
        final response = audioMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }
}
