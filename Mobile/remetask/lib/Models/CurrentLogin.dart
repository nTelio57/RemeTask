import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final API_Manager apiManager = API_Manager();

class CurrentLogin{
  static CurrentLogin? _instance;
  User? user;
  String? token;
  List<TaskGroup>? taskGroups;

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
    await loadTaskGroups();
  }

  bool hasTaskGroups()
  {
    return taskGroups != null;
  }

  Future<void> loadTaskGroups() async
  {
    taskGroups = await apiManager.TaskGroupsByUserId(CurrentLogin().user!.id);
  }



}