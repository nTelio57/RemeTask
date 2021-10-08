import 'package:remetask/Models/AuthRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String API_URL = 'remetask.herokuapp.com';
String registerUrl = '/api/User/register';

Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Map<String, String> defaultJWTHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

class API_Manager{
  Future<bool> RegisterUser(String email, String password) async {
    var authRequest = new AuthRequest(email, password);
    
    final response = await http.post(Uri.https(API_URL, registerUrl),
      headers: defaultHeaders,
      body: json.encode(authRequest.toJson())
    );

    if(response.statusCode == 200){
      print(response.body);
      var responseBody = AuthRequest.fromJson(jsonDecode(response.body));
      return true;
    }else{
      print(response.body);
      throw Exception('Failed to register');
    }
  }
}