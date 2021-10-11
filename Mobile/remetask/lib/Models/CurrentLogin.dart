import 'package:remetask/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLogin{
  static CurrentLogin? _instance;
  User? user;
  String? token;

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

}