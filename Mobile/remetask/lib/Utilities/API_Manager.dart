import 'package:remetask/Models/AuthRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:remetask/Models/AuthResult.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Invitation.dart';
import 'package:remetask/Models/InvitationResponse.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Response.dart';

String API_URL = 'remetask.herokuapp.com';

//Auth
String registerUrl = '/api/User/register';
String loginUrl = '/api/User/login';

//User
String getUsersByEmail = '/api/User/by-email/';

//Task groups
@deprecated
String taskGroupsByUserId = '/api/TaskGroup/by-user-id/';
String postTaskGroup = 'api/TaskGroup';

//Tasks
String postTask = '/api/Task';
String deleteTask = '/api/Task/';
String updateTask = '/api/Task/';

//Workspaces
String getWorkspaceTaskGroups = '/api/Workspace/';
String workspacesByUserId = '/api/Workspace/by-users-id/';
String getWorkspace = '/api/Workspace/';
String postWorkspace = '/api/Workspace';
String getUsersByWorkspace = '/api/Workspace/users/';

//Invitations
String postInvitation = '/api/Invitation';
String getInvitationsByUser = '/api/Invitation/by-users-id/';
String postInvitationResponse = '/api/Invitation/respond';

Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Map<String, String> defaultJWTHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'bearer '+CurrentLogin().token!,
};

class API_Manager{

  Future<AuthResult> RegisterUser(String email, String password) async {
    var authRequest = new AuthRequest(email, password);
    
    final response = await http.post(Uri.https(API_URL, registerUrl),
      headers: defaultHeaders,
      body: json.encode(authRequest.toJson())
    );

    if(response.statusCode == 201 || response.statusCode == 400){
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

  static Future<API_Response<List<User>>> GetUsersByEmail(String email) async
  {
    final response = await http.get(Uri.https(API_URL, getUsersByEmail+email),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200 || response.statusCode == 404) {
      List<dynamic> jsonData = json.decode(response.body);
      final parsed = jsonData.cast<Map<String, dynamic>>();

      return API_Response(parsed.map<User>((e) => User.fromJson(e)).toList(),
          response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get users by email');
    }
  }

  @deprecated
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

  static Future<API_Response<Task>> PostTask(Task task) async {
    final response = await http.post(Uri.https(API_URL, postTask),
        headers: defaultJWTHeaders,
        body: json.encode(task.toJson())
    );

    if(response.statusCode == 201){
      return API_Response(Task.fromJson(jsonDecode(response.body)), response.statusCode, response.reasonPhrase);
    }else{
      return API_Response(null, response.statusCode, response.reasonPhrase);
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

  static Future<bool> UpdateTask(int taskId, Task task) async {

    task.taskGroup = null;

    final response = await http.put(Uri.https(API_URL, (updateTask + taskId.toString())),
        headers: defaultJWTHeaders,
        body: json.encode(task.toJson())
    );

    if(response.statusCode == 204){
      return true;
    }else{
      throw Exception('Failed to update task');
    }
  }

  static Future<API_Response<List<Workspace>>> GetWorkspacesByUserId(String userId) async
  {
    final response = await http.get(Uri.https(API_URL, workspacesByUserId+userId),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200)
    {
      List<dynamic> jsonData = json.decode(response.body);
      final parsed = jsonData.cast<Map<String, dynamic>>();

      return API_Response(parsed.map<Workspace>((e) => Workspace.fromJson(e)).toList(), response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get workspaces by user id');
    }
  }

  static Future<API_Response<List<TaskGroup>>> GetWorkspaceTaskGroups(int workspaceId) async
  {
    final response = await http.get(Uri.https(API_URL, getWorkspaceTaskGroups+workspaceId.toString()+'/task-groups'),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200)
    {
      List<dynamic> jsonData = json.decode(response.body);
      final parsed = jsonData.cast<Map<String, dynamic>>();

      return API_Response(parsed.map<TaskGroup>((e) => TaskGroup.fromJson(e)).toList(), response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get workspace task groups');
    }
  }

  static Future<API_Response<TaskGroup>> PostTaskGroup(TaskGroup taskGroup) async{
    final response = await http.post(Uri.https(API_URL, postTaskGroup),
        headers: defaultJWTHeaders,
        body: json.encode(taskGroup.toJson())
    );

    if(response.statusCode == 201){
      return API_Response(TaskGroup.fromJson(jsonDecode(response.body)), response.statusCode, response.reasonPhrase);
    }else{
      throw Exception('Failed to post task group');
    }
  }

  static Future<API_Response<Workspace>> GetWorkspace(int id) async
  {
    final response = await http.get(Uri.https(API_URL, getWorkspace+id.toString()),
        headers: defaultJWTHeaders
    );

    print(response.body);
    if(response.statusCode == 200)
    {
      return API_Response(Workspace.fromJson(jsonDecode(response.body)), response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get workspace');
    }
  }

  static Future<API_Response<Workspace>> PostWorkspace(Workspace workspace) async{
    final response = await http.post(Uri.https(API_URL, postWorkspace),
        headers: defaultJWTHeaders,
        body: json.encode(workspace.toJson())
    );

    if(response.statusCode == 201){
      return API_Response(Workspace.fromJson(jsonDecode(response.body)), response.statusCode, response.reasonPhrase);
    }else{
      throw Exception('Failed to post task group');
    }
  }

  static Future<API_Response<List<User>>> GetUsersByWorkspace(int id) async
  {
    final response = await http.get(Uri.https(API_URL, getUsersByWorkspace+id.toString()),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200)
    {
      List<dynamic> jsonData = json.decode(response.body);
      final parsed = jsonData.cast<Map<String, dynamic>>();

      return API_Response(parsed.map<User>((e) => User.fromJson(e)).toList(), response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get users of workspace');
    }
  }

  static Future<API_Response<List<Invitation>>> GetInvitationsByUserId(String id) async
  {
    final response = await http.get(Uri.https(API_URL, getInvitationsByUser+id),
        headers: defaultJWTHeaders
    );

    if(response.statusCode == 200)
    {
      List<dynamic> jsonData = json.decode(response.body);
      final parsed = jsonData.cast<Map<String, dynamic>>();

      return API_Response(parsed.map<Invitation>((e) => Invitation.fromJson(e)).toList(), response.statusCode, response.reasonPhrase);
    }
    else{
      throw Exception('Failed to get users invitations');
    }
  }

  static Future<API_Response<Invitation>> PostInvitation(Invitation invitation) async{
    final response = await http.post(Uri.https(API_URL, postInvitation),
        headers: defaultJWTHeaders,
        body: json.encode(invitation.toJson())
    );

    if(response.statusCode == 201){
      return API_Response(Invitation.fromJson(jsonDecode(response.body)), response.statusCode, response.reasonPhrase);
    }else if(response.statusCode == 403)
      {
        return API_Response(null, response.statusCode, response.reasonPhrase);
      }
    else{
      throw Exception('Failed to post invitation response');
    }
  }

  static Future<API_Response<bool>> PostInvitationResponse(InvitationResponse invitationResponse) async{
    final response = await http.post(Uri.https(API_URL, postInvitationResponse),
        headers: defaultJWTHeaders,
        body: json.encode(invitationResponse.toJson())
    );

    if(response.statusCode == 200){
      return API_Response(true, response.statusCode, response.reasonPhrase);
    }else{
      throw Exception('Failed to post invitation response');
    }
  }
}