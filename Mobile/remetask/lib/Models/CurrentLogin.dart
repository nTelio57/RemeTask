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
  bool isLoaded = false;

  int _selectedWorkspaceId = -1;
  bool _isWorkspacesSet = false;
  List<Workspace> workspaces = [];
  List<Invitation> invitations = [];

  CurrentLogin._internal();

  factory CurrentLogin(){
    if(_instance == null){
      _instance = CurrentLogin._internal();
    }
    return _instance!;
  }

  void clear()
  {
    _instance = null;
  }

  void setCurrentLogin(User user, String token){
    this.user = user;
    this.token = token;

    saveToSharedPreferences();
  }

  SharedPreferences getSharedPreferences()
  {
    return prefs!;
  }

  Future<void> saveToSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString("token", token!);
    prefs!.setString("id", user!.id);
    prefs!.setString("email", user!.email);
  }

  Future<void> loadFromSharedPreferences() async
  {
    prefs = await SharedPreferences.getInstance();

    var token = prefs!.getString("token");
    var id = prefs!.getString("id");
    var email = prefs!.getString("email");

    setCurrentLogin(new User(id!, email!), token!);
  }

  int? getSelectedWorkspaceId()
  {
    if(_selectedWorkspaceId == -1)
      {
        var selectedWorkspaceIdFromPrefs = prefs!.getInt("selectedWorkspaceId");
        if(selectedWorkspaceIdFromPrefs != null)
          {
            _selectedWorkspaceId = selectedWorkspaceIdFromPrefs;
            return _selectedWorkspaceId;
          }
        return selectedWorkspaceIdFromPrefs;
      }
    return _selectedWorkspaceId;
  }

  void setSelectedWorkspaceId(int newId)
  {
    _selectedWorkspaceId = newId;
    prefs!.setInt("selectedWorkspaceId", newId);
  }

  void setWorkspaces(List<Workspace> workspaces)
  {
    this.workspaces = workspaces;
  }

  bool isWorkspaceSet()
  {
    return _isWorkspacesSet;
  }

  void setWorkspaceSet(bool value)
  {
    _isWorkspacesSet = value;
  }

  Workspace? getSelectedWorkspace()
  {
    var workspaceId = getSelectedWorkspaceId();
    if(workspaceId != null)
      {
        return workspaces.firstWhereOrNull((element) => element.id == workspaceId);
      }
    else if(workspaces.isNotEmpty)
      {
        return workspaces[0];
      }
    return null;
  }

  void setSelectedWorkspace(Workspace workspace)
  {
    setSelectedWorkspaceId(workspace.id!);
  }

  void setSelectedWorkspaceTasks(List<TaskGroup> taskGroups)
  {
    var selectedWorkspace = getSelectedWorkspace();
    if(selectedWorkspace != null)
      selectedWorkspace.taskGroups = taskGroups;
  }

  Workspace getWorkspace(int id)
  {
    return workspaces.firstWhere((element) => element.id == id);
  }

  Future<void> loadInvitations() async
  {
    var result = await API_Manager.GetInvitationsByUserId(user!.id);
    invitations = result.body!;
  }

  void addWorkspace(Workspace workspace)
  {
    workspaces.add(workspace);
  }

  void removeInvitation(Invitation invitation)
  {
    invitations.remove(invitation);
  }

  bool hasAnyWorkspace()
  {
    return workspaces.length > 0;
  }
}