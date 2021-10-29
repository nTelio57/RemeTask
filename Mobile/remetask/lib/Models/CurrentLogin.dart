import 'package:flutter/material.dart';
import 'package:remetask/Models/Invitation.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

final API_Manager apiManager = API_Manager();
SharedPreferences? prefs;

class CurrentLogin{
  static CurrentLogin? _instance;
  User? user;
  String? token;
  List<Workspace> workspaces = [];
  Workspace? selectedWorkspace;
  List<Invitation> invitations = [];

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
      var workspaceById = workspaces.firstWhereOrNull((element) => element.id == selectedWorkspaceId);
      if(workspaceById != null)
        setSelectedWorkspace(workspaceById);
      else if(workspaces.length > 0)
        setSelectedWorkspace(workspaces[0]);
    }
  }

  Future<void> reload() async
  {
    prefs = await SharedPreferences.getInstance();

    await loadWorkspaces();
    await loadInvitations();
  }

  Future<void> loadWorkspaces() async{
    workspaces = await  API_Manager.GetWorkspacesByUserId(user!.id);
    if(selectedWorkspace != null)
      {
        var workspaceById = workspaces.firstWhereOrNull((element) => element.id == selectedWorkspace!.id);
        if(workspaceById != null)
          {
            setSelectedWorkspace(workspaceById);
          }
      }

    workspaces.forEach((element) {loadWorkspaceMembers(element);});
  }

  Future<void> loadWorkspaceMembers(Workspace workspace) async
  {
    var members = await API_Manager.GetUsersByWorkspace(workspace.id!);
    workspace.users = members.body!;
  }

  bool hasAnyWorkspace()
  {
    return workspaces.length > 0;
  }

  bool hasAnyInvitation()
  {
    return invitations.length > 0;
  }

  Future<void> loadInvitations() async
  {
    var result = await API_Manager.GetInvitationsByUserId(user!.id);
    invitations = result.body!;
  }

  void removeInvitation(Invitation invitation)
  {
    invitations.remove(invitation);
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