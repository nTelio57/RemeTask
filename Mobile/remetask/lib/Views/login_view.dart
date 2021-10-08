import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

import 'register_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

bool _passwordVisible = false;

class _LoginViewState extends State<LoginView> {

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

 @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         background(),
         Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               topBox(),
               Expanded(
                   child: botBox()
               )
             ],
           )
         ),
         Padding(
           padding: const EdgeInsets.all(50.0),
           child: miniIcon(),
         ),
         Padding(
           child: mainBox(),
           padding: EdgeInsets.only(left: 25, right: 25, top: 270),
         )
       ],
     )
   );
  }

  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();

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
        padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
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
                  "Login",
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

  Widget botBox()
  {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
    );
  }

  Widget mainBox(){
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kSecondaryLightColor
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            emailField(),
            SizedBox(height: 20),
            passwordField(),
            SizedBox(height: 20),
            loginButton(),
            SizedBox(height: 20),
            dontHaveAnAccountCheck()
            //_forgotPasswordButton()
          ],
        ),
      ),
    );
  }


  Widget emailField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: _emailText,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans'
          ),
          decoration: InputDecoration(
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
      )
    ],
    );
  }

  Widget passwordField()
  {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: _passwordText,
          obscureText: !_passwordVisible,
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
      )
    ],
    );
  }

  Widget loginButton()
  {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 25.0),

      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () {
          print('Login clicked');
        } ,
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )
        ),
        child: Text(
          'Login',
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

  Widget forgotPasswordButton()
  {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 25.0),

      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () {
          print('Login clicked');
        },
        style: TextButton.styleFrom(
            primary: Colors.white
        ),
        child: Text(
          'Don\'t have an account?',
          style: TextStyle(
              color: kPrimaryColor,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
          ),
        ),
      ),
    );
  }

  Widget dontHaveAnAccountCheck()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don’t have an Account ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: () =>{
            Navigator.pushReplacement(context, new MaterialPageRoute(
                builder: (context) => RegisterView()
            ))
          },
          child: Text(
            "Sign Up",
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

  Widget topBoxText()
  {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Login to stay on your schedule. Organize your tasks and stop missing your deadlines.',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
}

