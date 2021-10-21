import 'package:flutter/material.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final API_Manager apiManager = API_Manager();

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token!);
    prefs.setInt("id", user!.id);
    prefs.setString("email", user!.email);
  }

  Future<void> load() async
  {
    await loadWorkspaces();
  }

  Future<void> loadWorkspaces() async{
    workspaces = await  API_Manager.GetWorkspacesByUserId(user!.id);
    if(workspaces.length > 0)
      selectedWorkspace = workspaces[0];
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