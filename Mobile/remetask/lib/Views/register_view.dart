import 'package:flutter/material.dart';
import 'package:remetask/Models/AuthResult.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/main_view.dart';
import 'package:remetask/Views/task_list_view.dart';

import 'login_view.dart';

final TextEditingController _emailText = TextEditingController();
final TextEditingController _passwordText = TextEditingController();
final TextEditingController _passwordRepeatText = TextEditingController();

bool _passwordVisible = false, _passwordRepeatVisible = false;

final API_Manager apiManager = API_Manager();

class RegisterView extends StatefulWidget {
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordRepeatVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Container(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  topBox(),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: miniIcon(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 270),
                    child: mainBox(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget mainBox(){
    return Container(
      height: 370,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kSecondaryLightColor
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              emailField(),
              SizedBox(height: 20),
              passwordField(),
              SizedBox(height: 20),
              passwordRepeatField(),
              SizedBox(height: 20),
              registerButton(),
              SizedBox(height: 20),
              alreadyHaveAnAccountCheck()
              //alreadyHaveAnAccountCheck()
              //_forgotPasswordButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        controller: _passwordText,
        obscureText: !_passwordVisible,
        validator: (value) {
          if(value == null || value.isEmpty)
          {
            return 'Enter password';
          }
          return null;
        },
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans'),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: kIconColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: kIconColor,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            hintText: "Password",
            hintStyle: kHintTextStyle
        ),
      ),
    );
  }

  Widget passwordRepeatField()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        controller: _passwordRepeatText,
        obscureText: !_passwordRepeatVisible,
        validator: (value) {
          if(value == null || value.isEmpty)
          {
            return 'Enter matching password';
          }else if(value != _passwordText.text)
            {
              return 'Password does not match';
            }
          return null;
        },
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans'),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: kIconColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordRepeatVisible ? Icons.visibility : Icons.visibility_off,
                color: kIconColor,
              ),
              onPressed: () {
                setState(() {
                  _passwordRepeatVisible = !_passwordRepeatVisible;
                });
              },
            ),
            hintText: "Confirm password",
            hintStyle: kHintTextStyle
        ),
      ),
    );
  }

  Widget background ()
  {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: kSecondaryColor,
    );
  }

  Widget topBox()
  {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              SizedBox(height: 30),
              backButton(),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              topBoxText()
            ],
          ),
        ),
      ),
    );
  }

  String _emailErrorText = '';

  Widget emailField() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60,
      child: TextFormField(
        controller: _emailText,
        validator: (value) {
          if(value == null || value.isEmpty)
            {
              return 'Enter email';
            }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans'
        ),
        decoration: InputDecoration(
          errorText: _emailErrorText.isEmpty ? null : _emailErrorText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey[600],
          ),
          hintText: "Email",
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }





  Widget registerButton()
  {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 25.0),

      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () async {
          setState(() {
            _emailErrorText = '';
          });
          print('Register clicked');
          if(_formKey.currentState!.validate())
            {
              AuthResult authResult = await apiManager.RegisterUser(_emailText.text, _passwordText.text);
              if(!authResult.success!){//failed
                setState(() {
                  _emailErrorText = authResult.errors![0];
                });
              }else{//succeeded
                CurrentLogin().setCurrentLogin(authResult.user!, authResult.token!);
                await CurrentLogin().load();
                Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
                    builder: (context) => MainView()
                ), (Route<dynamic> route) => false);
              }
            }
        } ,
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )
        ),
        child: Text(
          'Register',
          style: TextStyle(
              color: kTextOnPrimary,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
          ),
        ),
      ),
    );
  }

  Widget alreadyHaveAnAccountCheck()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an account ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: () =>{
            Navigator.pushReplacement(context, new MaterialPageRoute(
              builder: (context) => LoginView()
            ))
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget backButton()
  {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: Icon(Icons.west),
        onPressed: () {Navigator.pop(context);},
        iconSize: 42,
        color: kSecondaryLightColor,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
      ),
    );
  }

  Widget topBoxText()
  {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
          'Register to begin creating tasks, organize in team or solo and follow your unfinished jobs.',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }

  Widget miniIcon()
  {
    return Container(
      alignment: Alignment.center,
      //color: Colors.black,
      width: double.infinity,
      height: 50,
      child: LogoImage(
          width:50,
          height: 50
      ),
    );
  }
}