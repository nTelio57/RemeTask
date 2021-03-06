import 'package:flutter/material.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Views/main_view.dart';
import 'package:remetask/Views/task_list_view.dart';
import 'package:remetask/Views/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _defaultHome = new WelcomeView();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedInResult = await isLoggedIn();
  if(isLoggedInResult){
    _defaultHome = new MainView();
  }

  runApp(MyApp());
}

Future<bool> isLoggedIn() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");

  if(token == null || token.isEmpty) return false;

  await CurrentLogin().loadFromSharedPreferences();
  return true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,
    );
  }
}

