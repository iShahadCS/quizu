import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/models/http_exception.dart';
import 'package:quizu/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  // ignore: avoid_init_to_null
  User? currentUser = null;

//---------------------------------------------------------

  Future<bool> logIn(String phoneNum, String otp) async {
    final url = Uri.parse('https://quizu.okoul.com/Login');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "OTP": otp,
          "mobile": phoneNum,
        }));

    final responseData = json.decode(response.body);
    if (response.statusCode != 201) {
      throw HttpException(responseData['msg']);
    } else {
      if (responseData['name'] == null) {
        // true returned when the user has no name || status is new
        final localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", responseData["token"]);
        return true;
      } else {
        // false returned when the user has a name || status is Token returning
        final localStorage = await SharedPreferences.getInstance();
        final userData = json.encode(
            {'name': responseData['name'], 'mobile': responseData['mobile']});
        currentUser =
            User(mobile: responseData['mobile'], name: responseData['name']);
        localStorage.setString("token", responseData["token"]);
        localStorage.setString("userData", userData);
        return false;
      }
    }
  }

//---------------------------------------------------------

  Future<void> name(String token, String name) async {
    final url = Uri.parse('https://quizu.okoul.com/Name');
    final respone = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "name": name,
        }));

    final responseData = json.decode(respone.body);
    currentUser =
        User(mobile: responseData['mobile'], name: responseData['name']);

    final userData = json.encode(
        {'name': responseData['name'], 'mobile': responseData['mobile']});
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString("userData", userData);
  }

//---------------------------------------------------------

  Future<bool> tryAutoLogin() async {
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey("token")) {
      localStorage.reload();
      final token = localStorage.getString("token");
      final url = Uri.parse('https://quizu.okoul.com/Token');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = json.decode(response.body);
      print(responseData);
      //----------------------------------
      if (response.statusCode == 200) {
        // get user data
        final url = Uri.parse('https://quizu.okoul.com/UserInfo');
        final respone = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        final responseData = json.decode(respone.body);
        currentUser =
            User(mobile: responseData['mobile'], name: responseData['name']);

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }

    //---------------------------------------------------
  }

  //---------------------------------------------------
  Future<void> updateUserImage(File image) async {
    final imageBytes = await image.readAsBytes();
    final convertedImage = base64.encode(imageBytes);
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString("userImage", convertedImage);
    notifyListeners();
  }

  //---------------------------------------------------
  Future<void> logOut() async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    currentUser = null;
    notifyListeners();
  }

  User get getCurrentUser {
    return currentUser!;
  }

  Future<dynamic> getUserImage() async {
    final localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey("userImage")) {
      return base64.decode(localStorage.getString("userImage")!);
    } else {
      return null;
    }
  }
}
