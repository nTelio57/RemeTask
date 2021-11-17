import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/welcome_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  CurrentLogin user = CurrentLogin();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body()
  {
    return Container(
      child: Stack(
        children: [
          Background(color: kSecondaryColor),
          Column(
            children: [
              topBar(),
              Expanded(child: buttonList())
            ],
          )
        ],
      ),
    );
  }

  Widget topBar()
  {
    double iconSize = 100;

    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          picture(iconSize: iconSize),
          Expanded(
            child: Container(
              height: iconSize,
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameTextField(),
                  emailField()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonList()
  {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          listButton(
            text: 'Upgrade to PRO',
              icon: Icons.star_border,
            onPressed: (){
              onUpgradeToProPressed();
            }
          ),
          SizedBox(height: 8),
          listButton(
            text: 'Logout',
            icon: Icons.logout,
            onPressed: (){
              onLogoutPressed();
            }
          )
        ],
      ),
    );
  }

  Widget nameTextField()
  {
    return Container(
      child: Text(
        'Name Username Really Long ',
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'Nunito',
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                //fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }

  Widget emailField()
  {
    return Container(
      child: Text(
        user.user!.email,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'Nunito',
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
               // fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }

  Widget picture({double iconSize = 100})
  {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }

  void onUpgradeToProPressed()
  {
    print('Upgrade clicked');
    return;
  }

  void onLogoutPressed() async
  {
    await user.getSharedPreferences().clear();
    user.clear();
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
        builder: (context) => WelcomeView()
    ), (Route<dynamic> route) => false);
    return;
  }

  Widget listButton({double height = 45, String text = 'Button text', IconData icon = Icons.add, required void Function()? onPressed})
  {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        child: Row(
          children: [
            Container(
              child: Icon(
                icon,
                size: 30,
                color: kTextOnSecondary,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: kTextOnSecondary,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                    )
                ),
              ),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
