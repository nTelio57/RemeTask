import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

import 'login_view.dart';

final TextEditingController _emailText = TextEditingController();
final TextEditingController _passwordText = TextEditingController();
final TextEditingController _passwordRepeatText = TextEditingController();

bool _passwordVisible, _passwordRepeatVisible;

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
          topBox(),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 240),
            child: mainBox(),
          )
        ],
      ),
    );
  }

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

  Widget passwordRepeatField()
  {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: _passwordRepeatText,
          obscureText: !_passwordRepeatVisible,
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
      )
    ],
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
      height: 300,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Align(
          alignment: Alignment(-1,0.1),
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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





  Widget registerButton()
  {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 25.0),

      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () {
          print('Register clicked');
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
}