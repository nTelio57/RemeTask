import 'package:flutter/material.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final API_Manager apiManager = API_Manager();
SharedPreferences? prefs;

class CurrentLogin{
  static CurrentLogin? _instance;
  User? user;
  String? token;
  List<Workspace> workspaces = [];
  Workspace? selectedWorkspace;

  CurrentLogin._internal();

  factory CurrentLogin(){
    if(_instance == null){
      _instance = CurrentLogin._internal();
    }
    return _instance!;
  }

  void setCurrentLogin(User user, String token){
    this.user = user;
    this.token = token;

    saveToSharedPreferences();
  }

  Future<void> saveToSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString("token", token!);
    prefs!.setInt("id", user!.id);
    prefs!.setString("email", user!.email);
    if(selectedWorkspace != null)
      prefs!.setInt("selectedWorkspaceId", selectedWorkspace!.id!);
  }

  Future<void> loadFromSharedPreferences() async
  {
    prefs = await SharedPreferences.getInstance();

    var token = prefs!.getString("token");
    var id = prefs!.getInt("id");
    var email = prefs!.getString("email");
    var selectedWorkspaceId = prefs!.getInt("selectedWorkspaceId");

    setCurrentLogin(new User(id!, email!), token!);

    await reload();

    if(selectedWorkspaceId != null)
    {
      print('Current user load from prefs, selected workspace id load: ' + selectedWorkspaceId.toString());
      setSelectedWorkspace(workspaces.firstWhere((element) => element.id == selectedWorkspaceId));
    }
  }

  Future<void> reload() async
  {
    prefs = await SharedPreferences.getInstance();

    await loadWorkspaces();
  }

  Future<void> loadWorkspaces() async{
    workspaces = await  API_Manager.GetWorkspacesByUserId(user!.id);
    if(workspaces.length > 0)
      setSelectedWorkspace(workspaces[0]);
  }

  bool hasAnyWorkspace()
  {
    if(workspaces.length == 0)
      {
        return false;
      }
    return true;
  }

  Workspace getSelectedWorkspace()
  {
    return selectedWorkspace!;
  }

  void setSelectedWorkspace(Workspace workspace)
  {
    selectedWorkspace = workspace;
    prefs!.setInt("selectedWorkspaceId", selectedWorkspace!.id!);
  }

  void addWorkspace(Workspace workspace)
  {
    workspaces.add(workspace);
  }

  /*bool hasTaskGroups()
  {
    return taskGroups != null;
  }

  Future<void> loadTaskGroups() async
  {
    taskGroups = await apiManager.TaskGroupsByUserId(user!.id);
  }

  void removeTaskFromList(int taskId, int taskGroupId)
  {
    taskGroups!.where((group) => group.id == taskGroupId).first.tasks.removeWhere((task) => task.id == taskId);
  }*/

}