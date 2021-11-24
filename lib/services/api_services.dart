import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rcn/model/announcement_model.dart';
import 'package:rcn/model/audio_msg_model.dart';
import 'package:rcn/model/itestify_model.dart';
import 'package:rcn/model/itinerary_model.dart';
import 'package:rcn/model/nearest_rcn_model.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/model/slider.dart';
import 'package:rcn/model/video_msg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static var client = http.Client();
  static String _mybaseUrl = 'http://arome.joons-me.com/Api/';
  static String _sliderPath = 'get_slider';
  static String _seek_god = 'seek_god';
  static String _itinerary = 'itinerary';
  static String _audio_msg = 'audio_msg';
  static String _search_audio_msg = 'search_audio';
  static String _toggle_audio_playlist = 'toggle_audio_playlist';
  static String _video_msg = 'video_msg';
  static String _search_video_msg = 'search_video';
  static String _toggle_video_playlist = 'toggle_video_playlist';
  static String _announcement = 'announcement';
  static String _nearest_rcn = 'nearest_rcn';
  static String _itestify = 'itestify';
  static String _toggle_testimony = 'toggle_testimony';
  static String _add_itestify = 'add_itestify';
  static String _report_test = 'itestify_report_problem';
  static String _itestify_block_user = 'itestify_block_user';
  static String _itestify_delete = 'delete_itestify_for_me';
  static String _send_message = 'send_private_message';
  static String _login_authorization = 'login_authorization';
  static String _signup_authorization = 'signup_authorization';
  static String _reset_password = 'reset_password';
  static String _live_stream_status = 'get_live_streaming_status';
  static String _live_stream_link = 'get_live_streaming_link';
  static String _video_playlist = 'get_video_playlist';
  static String _audio_playlist = 'get_audio_playlist';

  static Future<List<SliderModel>?> getApiSlider() async {
    final result = await client.get(Uri.parse('$_mybaseUrl$_sliderPath'));
    if (result.statusCode == 200) {
      final slider = sliderModelFromJson(result.body);
      return slider;
    } else {
      return null;
    }
  }

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
        final response = audioMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static getAudioPlaylistMsg(var page_num, var user_id) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_audio_playlist/$page_num/$user_id'));
      if (result.statusCode == 200) {
        final response = audioMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<AudioMsg>> getSearchAudioMsg(
      var current_page, String search_term, var user_id) async {
    final uri =
        Uri.parse('$_mybaseUrl$_search_audio_msg/$current_page/$user_id');

    var response = await http.post(uri, body: {
      'search_term': search_term,
    });

    return audioMsgFromJson(response.body);
  }

  static Future<String> toggleAudioPlaylist(var user_id, var audio_id) async {
    final response = await http.get(
        Uri.parse('$_mybaseUrl$_toggle_audio_playlist/$user_id/$audio_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<List<VideoMsg>> getVideoMsg(var page_num, var user_id) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_video_msg/$page_num/$user_id'));
      if (result.statusCode == 200) {
        final response = videoMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<VideoMsg>> getPlaylistVideoMsg(
      var page_num, var user_id) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_video_playlist/$page_num/$user_id'));

      if (result.statusCode == 200) {
        final response = videoMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<VideoMsg>> getSearchVideoMsg(
      var current_page, String search_term, var user_id) async {
    final uri =
        Uri.parse('$_mybaseUrl$_search_video_msg/$current_page/$user_id');

    var response = await http.post(uri, body: {
      'search_term': search_term,
    });

    return videoMsgFromJson(response.body);
  }

  static Future<String> toggleVideoPlaylist(var user_id, var audio_id) async {
    final response = await http.get(
        Uri.parse('$_mybaseUrl$_toggle_video_playlist/$user_id/$audio_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<List<AnnouncementModel>> getAnnouncement(var page_num) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_announcement/$page_num'));
      if (result.statusCode == 200) {
        final an = announcementModelFromJson(result.body);
        return an;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<NearestRcnModel>> getNearestRCN(var page_num) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_nearest_rcn/$page_num'));
      if (result.statusCode == 200) {
        final an = nearestRcnModelFromJson(result.body);
        return an;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<List<ItestifyModel>> getItestify(
      var page_num, var user_id) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_itestify/$page_num/$user_id'));
      if (result.statusCode == 200) {
        final response = itestifyModelFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  static Future<String> toggleTestimonylist(var user_id, var test_id) async {
    final response = await http
        .get(Uri.parse('$_mybaseUrl$_toggle_testimony/$user_id/$test_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> submitTestimony(var user_id, var msg) async {
    final uri = Uri.parse('$_mybaseUrl$_add_itestify');

    var response = await http.post(uri, body: {
      'message': msg,
      'user_id': user_id.toString(),
    });

    var body = response.body;

    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> report_testimony(
      var user_id, var test_id, var report_type) async {
    final response = await http.get(
        Uri.parse('$_mybaseUrl$_report_test/$test_id/$report_type/$user_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> block_test_user(var user_id, var test_id) async {
    final response = await http
        .get(Uri.parse('$_mybaseUrl$_itestify_block_user/$test_id/$user_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> delete_test(var user_id, var test_id) async {
    final response = await http
        .get(Uri.parse('$_mybaseUrl$_itestify_delete/$test_id/$user_id'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<bool> submitMessage(var email, var name, var msg) async {
    final uri = Uri.parse('$_mybaseUrl$_send_message');

    var response = await http.post(uri, body: {
      'message': msg,
      'email': email,
      'name': name,
    });

    var body = response.body;

    final j = json.decode(body) as Map<String, dynamic>;
    bool status = j['status'];
    return status;
  }

  static Future<String> userAuthLogin(String email, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$_mybaseUrl$_login_authorization');

    var response = await http.post(uri, body: {
      'email': email,
      'password': pass,
    });

    Map<String, dynamic> j = json.decode(response.body);
    String status = j['status'];
    String status_msg = j['status_msg'];

    if (status == 'success') {
      String user_id = j['user_id'];
      String full_name = j['full_name'];
      String age = j['age'];
      String sex = j['sex'];
      String emailAddres = j['email'];
      String phone_no = j['phone_no'];
      String user_img = j['user_img'];
      String user_name = j['user_name'];
      String is_profile_updated = j['is_profile_updated'];

      prefs.setString('user_id', user_id);
      prefs.setString('full_name', full_name);
      prefs.setString('age', age);
      prefs.setString('sex', sex);
      prefs.setString('email', emailAddres);
      prefs.setString('phone_no', phone_no);
      prefs.setString('user_img', user_img);
      prefs.setBool('isUserLogin', true);
      // prefs.setBool('profile_updated', is_profile_updated);
      prefs.setBool('profile_updated', false);
      prefs.setString('user_name', user_name);

      return status;
    } else if (status == 'fail_01' ||
        status == 'fail_02' ||
        status == 'fail_03' ||
        status == 'fail_04') {
      return status;
    }
    return "fail";
  }

  static Future<String> userAuthSignup(
      String email, String pass, String user_name, String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$_mybaseUrl$_signup_authorization');

    var response = await http.post(uri, body: {
      'email': email,
      'password': pass,
      'user_name': user_name,
      'gender': gender,
    });

    Map<String, dynamic> j = json.decode(response.body);
    String status = j['status'];
    String status_msg = j['status_msg'];

    if (status == 'success') {
      String user_id = j['user_id'];
      String full_name = j['full_name'];
      String age = j['age'];
      String sex = j['sex'];
      String emailAddres = j['email'];
      String phone_no = j['phone_no'];
      String user_img = j['user_img'];
      String user_name = j['user_name'];
      bool is_profile_updated = j['is_profile_updated'];

      prefs.setString('user_id', user_id);
      prefs.setString('full_name', full_name);
      prefs.setString('age', age);
      prefs.setString('sex', sex);
      prefs.setString('email', emailAddres);
      prefs.setString('phone_no', phone_no);
      prefs.setString('user_img', user_img);
      prefs.setBool('isUserLogin', true);
      prefs.setBool('profile_updated', is_profile_updated);
      prefs.setString('user_name', user_name);

      return status;
    } else if (status == 'fail_01' ||
        status == 'fail_02' ||
        status == 'fail_03' ||
        status == 'fail_04' ||
        status == 'fail_05') {
      return status;
    }
    return "fail";
  }

  static Future<String> userAuthRest(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$_mybaseUrl$_reset_password');

    var response = await http.post(uri, body: {
      'email': email,
    });

    Map<String, dynamic> j = json.decode(response.body);
    String status = j['status'];

    if (status == 'success') {
      return status;
    } else if (status == 'fail_01' ||
        status == 'fail_02' ||
        status == 'fail_03' ||
        status == 'fail_04') {
      return status;
    }

    return "fail";
  }

  static Future<bool> updateUserProfile(String name, String age, String phone,
      File profileImg, String sex, String my_id, var user_name) async {
    final uri = Uri.parse('$_mybaseUrl/update_profile/$my_id');
    var request = http.MultipartRequest('POST', uri);
    request.fields['full_name'] = name;
    request.fields['age'] = age;
    request.fields['phone'] = phone;
    request.fields['sex'] = sex;

    var profileImage =
        await http.MultipartFile.fromPath('profile_image', profileImg.path);
    request.files.add(profileImage);

    var respond = await request.send();
    if (respond.statusCode == 200) {
      var new_user_img = 'https://arome.joons-me.com/user_img/$user_name' +
          '/images/' +
          profileImage.filename!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('full_name', name);
      prefs.setString('age', age);
      prefs.setString('sex', sex);
      prefs.setString('phone_no', phone);
      prefs.setString('user_img', new_user_img);
      prefs.setBool('profile_updated', true);
      return true;
    } else {
      return false;
    }
  }

  static Future<String> get_live_status() async {
    final response =
        await http.get(Uri.parse('$_mybaseUrl$_live_stream_status'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> get_live_link() async {
    final response = await http.get(Uri.parse('$_mybaseUrl$_live_stream_link'));
    var body = response.body;
    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  Future<int> isAppHasNewUpdate() async {
    final response = await http.get(Uri.parse('$_mybaseUrl/has_new_update/'));

    Map<String, dynamic> j = json.decode(response.body);
    int counter = j['counter'];
    return counter;
  }

  Future<String> iosStoreLink() async {
    final response = await http.get(Uri.parse('$_mybaseUrl/ios_store_link/'));

    Map<String, dynamic> j = json.decode(response.body);
    String counter = j['link'];
    return counter;
  }

  Future<String> androidStoreLink() async {
    final response =
        await http.get(Uri.parse('$_mybaseUrl/android_store_link/'));

    Map<String, dynamic> j = json.decode(response.body);
    String counter = j['link'];
    return counter;
  }

  Future<bool> deleteMyAccount(my_id) async {
    final response =
        await http.get(Uri.parse('$_mybaseUrl/delete_account/$my_id'));

    Map<String, dynamic> j = json.decode(response.body);
    bool checker = j['status'];
    // return true;
    return checker;
  }
}
