import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class LoginView extends StatelessWidget {
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
               //SizedBox(height: 250),
               SizedBox(
                    child: topBox(),
                    height: 250,
               ),
               Expanded(
                   child: botBox()
               )
             ],
           )
         ),
         Padding(
           child: loginBox(),
           padding: EdgeInsets.only(left: 25, right: 25, top: 200),
         )
         /*Container(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 //TopBox(),
                 Expanded(
                     child: BotBox()
                 )
               ],
             )
         )*/
       ],
     )
   );
  }
}



final TextEditingController _emailText = TextEditingController();
final TextEditingController _passwordText = TextEditingController();

Widget background ()
{
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: kPrimaryColor,

  );
}

Widget topBox()
{
  return Container(
    width: double.infinity,
    child: Align(
      alignment: Alignment(0,0.1),
      child: Text(
        "Login",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 40.0,
            fontWeight: FontWeight.bold
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

Widget loginBox(){
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
          alreadyHaveAnAccountCheck()
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
        obscureText: true,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans'),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey[600],
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

Widget alreadyHaveAnAccountCheck()
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
          print('Sign up clicked')
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

