import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixtaplayer/login_response.dart';
import 'package:mixtaplayer/signup_response.dart';

class ApiCalls {
  Future signUp(String email, String username, String password) async {
    try {
      final url = Uri.parse("https://mixtaplay.herokuapp.com/users/signup");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "email": email,
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data['token']);
        print('working response');
        return SignupResponse.fromJson(data);
      } else {
        var failedMsg = jsonDecode(response.body);
        print(failedMsg['message']);
        //print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future login(String email, String password) async {
    try {
      final url = Uri.parse("https://mixtaplay.herokuapp.com/users/login");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "email": email,
            "password": password,
          }));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['token']);
        print('working response');
        return LoginResponseModel.fromJson(data);
      } else {
        var failedMsg = jsonDecode(response.body);
        print(failedMsg['message']);
        //print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
