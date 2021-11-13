import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rcn/model/audio_msg_model.dart';
import 'package:rcn/model/itinerary_model.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/model/slider.dart';
import 'package:rcn/model/video_msg_model.dart';

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
        final response = audioMsgFromJson(result.body);
        return response;
      } else {
        return Future.error('Unwanted status Code');
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }

  // static Future<List<AudioMsg>> getSearchAudioMsg(
  //     var page_num, var search_term, var user_id) async {
  //   try {
  //     final result = await client
  //         .get(Uri.parse('$_mybaseUrl$_audio_msg/$page_num/$user_id'));
  //     if (result.statusCode == 200) {
  //       final response = audioMsgFromJson(result.body);
  //       return response;
  //     } else {
  //       return Future.error('Unwanted status Code');
  //     }
  //   } catch (ex) {
  //     return Future.error(ex.toString());
  //   }
  // }

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

    // print(body);
    // try {
    //   final myObject = json.decode(response.body) as Object?;
    //   if (myObject is! Map) throw FormatException();
    //   final name = myObject['status'] as String;
    //   return name;
    // } on FormatException {
    //   print('JSON is in the wrong format');
    //   return 'N';
    // }
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

  // Future<List<UserProfile>> searchUsersByPage(
  //     String search_term, int current_page, String my_id) async {
  //   final uri = Uri.parse('$mainUrl/search_users/$current_page/$my_id');
  //
  //   var response = await http.post(uri, body: {
  //     'search_term': search_term,
  //   });
  //
  //   return userProfileFromJson(response.body);
  // }
  //
  // Future<String> userAuthLogin(String email, String pass) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uri = Uri.parse('$mainUrl/login_authorization');
  //
  //   var response = await http.post(uri, body: {
  //     'email': email,
  //     'password': pass,
  //   });
  //
  //   Map<String, dynamic> j = json.decode(response.body);
  //   String status = j['status'];
  //   String status_msg = j['status_msg'];
  //
  //   if (status == 'success') {
  //     String system_id = j['system_id'];
  //     String user_id = j['user_id'];
  //     String full_name = j['full_name'];
  //     String age = j['age'];
  //     String sex = j['sex'];
  //     String emailAddres = j['email'];
  //     String phone_no = j['phone_no'];
  //     String user_img = j['user_img'];
  //     int following = j['following'];
  //     int followers = j['followers'];
  //
  //     prefs.setString('system_id', system_id);
  //     prefs.setString('user_id', user_id);
  //     prefs.setString('full_name', full_name);
  //     prefs.setString('age', age);
  //     prefs.setString('sex', sex);
  //     prefs.setString('email', emailAddres);
  //     prefs.setString('phone_no', phone_no);
  //     prefs.setString('user_img', user_img);
  //     prefs.setBool('isUserLogin', true);
  //     prefs.setBool('profile_updated', false);
  //
  //     return status;
  //   } else if (status == 'fail_01' ||
  //       status == 'fail_02' ||
  //       status == 'fail_03' ||
  //       status == 'fail_04') {
  //     return status;
  //   }
  // }
  //
  // Future<String> userAuthSignup(String email, String pass) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uri = Uri.parse('$mainUrl/signup_authorization');
  //
  //   var response = await http.post(uri, body: {
  //     'email': email,
  //     'password': pass,
  //   });
  //
  //   Map<String, dynamic> j = json.decode(response.body);
  //   String status = j['status'];
  //   String status_msg = j['status_msg'];
  //
  //   if (status == 'success') {
  //     String system_id = j['system_id'];
  //     String user_id = j['user_id'];
  //     String full_name = j['full_name'];
  //     String age = j['age'];
  //     String sex = j['sex'];
  //     String emailAddres = j['email'];
  //     String phone_no = j['phone_no'];
  //     String user_img = j['user_img'];
  //     int following = j['following'];
  //     int followers = j['followers'];
  //
  //     prefs.setString('system_id', system_id);
  //     prefs.setString('user_id', user_id);
  //     prefs.setString('full_name', full_name);
  //     prefs.setString('age', age);
  //     prefs.setString('sex', sex);
  //     prefs.setString('email', emailAddres);
  //     prefs.setString('phone_no', phone_no);
  //     prefs.setString('user_img', user_img);
  //     //prefs.setBool('isUserLogin', true);
  //     prefs.setBool('profile_updated', false);
  //
  //     return status;
  //   } else if (status == 'fail_01' ||
  //       status == 'fail_02' ||
  //       status == 'fail_03' ||
  //       status == 'fail_04') {
  //     return status;
  //   }
  // }
  //
  // Future<String> userAuthRest(String email) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final uri = Uri.parse('$mainUrl/reset_password');
  //
  //   // print(email);
  //   var response = await http.post(uri, body: {
  //     'email': email,
  //   });
  //
  //   // print(response.body);
  //   Map<String, dynamic> j = json.decode(response.body);
  //   String status = j['status'];
  //
  //   if (status == 'success') {
  //     return status;
  //   } else if (status == 'fail_01' ||
  //       status == 'fail_02' ||
  //       status == 'fail_03' ||
  //       status == 'fail_04') {
  //     return status;
  //   }
  // }
  //
  // Future<bool> updateUserProfile(
  //     {String name,
  //       String age,
  //       String phone,
  //       File profileImg,
  //       String my_id}) async {
  //   //return forumCommentFromJson(response.body);
  //
  //   final uri = Uri.parse('$mainUrl/update_profile/$my_id');
  //   var request = http.MultipartRequest('POST', uri);
  //   request.fields['full_name'] = name;
  //   request.fields['age'] = age;
  //   request.fields['phone'] = phone;
  //
  //   var profileImage =
  //   await http.MultipartFile.fromPath('profile_image', profileImg.path);
  //   request.files.add(profileImage);
  //
  //   var respond = await request.send();
  //   if (respond.statusCode == 200) {
  //     var new_user_img = 'https://api.osherwomen.com/user_img/$my_id' +
  //         '/' +
  //         profileImage.filename;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('full_name', name);
  //     prefs.setString('age', age);
  //     prefs.setString('phone_no', phone);
  //     prefs.setString('user_img', new_user_img);
  //     prefs.setBool('profile_updated', true);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  // Future<List<ForumComment>> commentReportProblem(
  //     String id,
  //     String report_type,
  //     BuildContext context,
  //     String forum_id,
  //     String user,
  //     ) async {
  //   final response = await http.get(Uri.parse(
  //       '$mainUrl/comment_report_problem/$forum_id/$id/$report_type/$user'));
  //   var body = response.body;
  //
  //   // print(forum_id);
  //   // print(id);
  //   Map<String, dynamic> j = json.decode(body);
  //   String status = j['status'];
  //   String status_msg = j['status_msg'];
  //
  //   if (status == 'true') {
  //     final snacksBar = SnackBar(
  //       content: Text('Comment has been Submitted for Review!'),
  //       //action: SnackBarAction(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snacksBar);
  //
  //     // return forumFromJson(body_forum);
  //   } else if (status == 'fail_01' ||
  //       status == 'fail_02' ||
  //       status == 'fail_03' ||
  //       status == 'fail_04') {
  //     final snacksBar = SnackBar(
  //       content: Text(status_msg),
  //       //action: SnackBarAction(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snacksBar);
  //     //return forumFromJson(response.body[0]);
  //   }
  // }
  //
  // Future<bool> commentBlockUser({
  //   String id,
  //   String user,
  //   BuildContext context,
  // }) async {
  //   final response =
  //   await http.get(Uri.parse('$mainUrl/comment_block_user/$id/$user'));
  //   var body = response.body;
  //
  //   Map<String, dynamic> j = json.decode(body);
  //   String status = j['status'];
  //
  //   if (status == 'true') {
  //     final snacksBar = SnackBar(
  //       content: Text('You won\'t seen this user post anymore'),
  //       //action: SnackBarAction(),
  //     );
  //
  //     ScaffoldMessenger.of(context).showSnackBar(snacksBar);
  //     return true;
  //   } else if (status == 'false') {
  //     final snacksBar = SnackBar(
  //       content: Text('Could not perform operation, Try Later!'),
  //       //action: SnackBarAction(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snacksBar);
  //     return false;
  //   } else if (status == 'already') {
  //     final snacksBar = SnackBar(
  //       content: Text('User already Blocked!'),
  //       //action: SnackBarAction(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snacksBar);
  //     return false;
  //   }
  // }

//   Future<bool> sendPrivateMsg({
//     String name,
//     String email,
//     String message,
//   }) async {
//     final uri = Uri.parse('$mainUrl/send_private_message');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = name;
//     request.fields['email'] = email;
//     request.fields['message'] = message;
//
//     var respond = await request.send();
//
//     //print(respond);
//     if (respond.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
// //Quote Yes Counter
//   Future<int> getCurrentQuoteYesCounter(String id) async {
//     final response =
//     await http.get(Uri.parse('$mainUrl/getCurrentQuoteYesCount/$id'));
//     var body = response.body;
//     Map<String, dynamic> j = json.decode(body);
//     bool status = j['status'];
//     int counter = j['counter'];
//     // print('Counter Plus ${counter}');
//     // print('Status Plus ${status}');
//     if (status == true) {
//       return counter;
//     } else {
//       return 0;
//     }
//   }

}
