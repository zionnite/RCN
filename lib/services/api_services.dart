import 'package:http/http.dart' as http;
import 'package:rcn/model/slider.dart';

class ApiServices {
  static var client = http.Client();
  static String mybaseUrl = 'http://arome.joons-me.com/Api/';
  static String sliderPath = 'get_slider';

  static Future<List<SliderModel>?> getApiSlider() async {
    final result = await client.get(Uri.parse('$mybaseUrl$sliderPath'));
    if (result.statusCode == 200) {
      final slider = sliderModelFromJson(result.body);
      return slider;
    } else {
      return null;
    }
  }
}
