import 'package:remetask/Models/AuthRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:remetask/Models/AuthResult.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';

String API_URL = 'remetask.herokuapp.com';

//Auth
String registerUrl = '/api/User/register';
String loginUrl = '/api/User/login';

//Task groups
String taskGroupsByUserId = '/api/TaskGroup/by-user-id/';

//Tasks
String postTask = '/api/Task';
String deleteTask = '/api/Task/';

Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Map<String, String> defaultJWTHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'bearer '+('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwibmJmIjoxNjMzODA1NDIxLCJleHAiOjE2MzY0ODM4MjEsImlhdCI6MTYzMzgwNTQyMX0.lHnySUe2KWP3ngfPBQ73hmbEYXVuwc4RfgljhIw8Cd8'),
};

class API_Manager{

  Future<AuthResult> RegisterUser(String email, String password) async {
    var authRequest = new AuthRequest(email, password);
    
    final response = await http.post(Uri.https(API_URL, registerUrl),
      headers: defaultHeaders,
      body: json.encode(authRequest.toJson())
    );

    if(response.statusCode == 200 || response.statusCode == 400){
      var responseBody = AuthResult.fromJson(jsonDecode(response.body));
      return responseBody;
    }else{
      throw Exception('Failed to register');
    }
  }

  Future<AuthResult> Login(String email, String password) async {
    var authRequest = new AuthRequest(email, password);

    final response = await http.post(Uri.https(API_URL, loginUrl),
        headers: defaultHeaders,
        body: json.encode(authRequest.toJson())
    );

    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 400){
      return AuthResult.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to login');
    }
  }

  Future<List<TaskGroup>> TaskGroupsByUserId(int userId) async{
    final response = await http.get(Uri.https(API_URL, taskGroupsByUserId+userId.toString()),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200)
      {
        List<dynamic> jsonData = json.decode(response.body);
        final parsed = jsonData.cast<Map<String, dynamic>>();

        return parsed.map<TaskGroup>((e) => TaskGroup.fromJson(e)).toList();
      }
    else{
      throw Exception('Failed to get task groups by user id');
    }
  }

  static Future<Task> PostTask(Task task) async {
    final response = await http.post(Uri.https(API_URL, postTask),
        headers: defaultJWTHeaders,
        body: json.encode(task.toJson())
    );

    if(response.statusCode == 201){
      return Task.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to post task');
    }
  }

  static Future<bool> DeleteTask(int taskId) async {
    final response = await http.delete(Uri.https(API_URL, (deleteTask + taskId.toString())),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 204){
      return true;
    }else{
      throw Exception('Failed to delete task');
    }
  }
}