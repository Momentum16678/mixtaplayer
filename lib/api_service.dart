import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future signUp(String email, String username, String password) async {
    try {
      final url = Uri.parse(
          "https://mixtaplay.herokuapp.com/users/signup");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "email": email,
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 201) {
       // var data = jsonDecode(response.body.toString());
       // print(data['token']);
        print('working response');
      } else {
        print(response.statusCode);
        //print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
