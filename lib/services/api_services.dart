import 'package:http/http.dart' as http;
import 'package:rcn/model/itinerary_model.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/model/slider.dart';

class ApiServices {
  static var client = http.Client();
  static String mybaseUrl = 'http://arome.joons-me.com/Api/';
  static String sliderPath = 'get_slider';
  static String seek_god = 'seek_god';
  static String itinerary = 'itinerary';

  static Future<List<SliderModel>?> getApiSlider() async {
    final result = await client.get(Uri.parse('$mybaseUrl$sliderPath'));
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
          await client.get(Uri.parse('$mybaseUrl$seek_god/$page_num'));
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
          await client.get(Uri.parse('$mybaseUrl$itinerary/$page_num'));
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
}
