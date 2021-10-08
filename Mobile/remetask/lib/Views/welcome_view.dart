import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Views/login_view.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          topBox(),
          mainBox()
        ],
      ),
    );
  }
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
  return Stack(
    children: [
      Container(
          height: 410,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          alignment: Alignment(0,-0.4),
          child: Container(
            height: 140,
            child: Column(
              children: [
                logo(),
                SizedBox(height: 5),
                logoText()
              ],
            ),
          )
      ),
      /*Container(
        color: Colors.black,
        child: Align(
          alignment: Alignment(0,0),
          child: Column(
            children: [
              logo(),
              logoText()
            ],
          ),
        ),
      )*/
    ],
  );
}

Widget logo(){
  return Container(
    width: 100,
    height: 100,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kSecondaryLightColor,
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
        ),
        Center(
          child: Container(
              width: 75,
              height: 75,
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png')
                ],
              )
          ),
        )
      ],
    ),
  );
}

Widget logoText()
{
  return Container(
    child: Text(
      'Remetask',
      style: TextStyle(
          color: kSecondaryLightColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
          fontSize: 25
      ),
    ),
  );
}

Widget mainBox(){
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 260),
    child: Container(
      height: 330,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kSecondaryLightColor
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          children: [
            welcomeText(),
            SizedBox(height: 40),
            loginButton(),
            SizedBox(height: 20),
            registerButton()
            //passwordField(),
            //_forgotPasswordButton()
          ],
        ),
      ),
    ),
  );
}

Widget welcomeText(){
  return Container(
    width: double.infinity,
    child: Column(
      children: [
        Text(
          'Welcome to Remetask',
          style: TextStyle(
            color: kTextOnSecondary,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Organize your tasks and keep your deadlines away',
            style: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'OpenSans',
                fontSize: 15,

            ),
          textAlign: TextAlign.center,
        )
      ],
    )
  );
}

Widget loginButton()
{
  return Container(
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

Widget registerButton()
{
  return Container(
    width: double.infinity,
    height: 50,
    child: OutlinedButton(
      onPressed: () {
        print('Register clicked');
      } ,
      style: OutlinedButton.styleFrom(
          primary: Colors.black,
          side: BorderSide(
              color: kPrimaryColor,
              width: 3
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
          )
      ),
      child: Text(
        'Register',
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