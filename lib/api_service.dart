import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixtaplayer/signin_response.dart';

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
        print(response.statusCode);
        //print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
