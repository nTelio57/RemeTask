import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Invitation.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

List<User> users = [];
FToast? _toast;

class InvitationCreateView extends StatefulWidget {
  InvitationCreateView({Key? key, required this.workspace}) : super(key: key);

  Workspace workspace;

  @override
  _InvitationCreateViewState createState() => _InvitationCreateViewState();
}

class _InvitationCreateViewState extends State<InvitationCreateView> {
  @override
  Widget build(BuildContext context) {

    _toast = FToast();
    _toast!.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Invite member'),
        backgroundColor: kSecondaryLightColor,
        foregroundColor: kPrimaryColor,
      ),
      body: body(),
    );
  }

  Widget body()
  {
    return Stack(
      children: [
        Background(color: kSecondaryColor),
        Container(
          child: Column(
            children: [
              newMemberEmailField(),
              listBuilder()
            ],
          ),
        )
      ],
    );
  }

  void _onInviteClick(Workspace workspace, User invitee, User inviter)
  {
    print('invitee: ${invitee.email}  inviter: ${inviter.email} workspace: ${workspace.name}');
    var invitation = new Invitation(invitationDate: DateTime.now(), workspaceId: workspace.id!, inviterId: inviter.id, inviteeId: invitee.id);
    print(CurrentLogin().roles);
    if(!CurrentLogin().isPro())
      {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return notProDialog();
            }
        );
      }else
        {
          API_Manager.PostInvitation(invitation);
          showToast(successToast());
        }
  }

  Widget notProDialog()
  {
    return Container(
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Wrap(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    color: kPrimaryColor,
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                    alignment: Alignment.center,
                    child: Text(
                      'Upgrade to PRO to invite other users to your worksapce!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: kTextOnPrimary,
                            fontSize: 25,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                  ),
                  Container(
                      child: upgradeToProButton(),
                      color: kPrimaryColor,
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 24)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upgradeToProButton()
  {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: ()  {
        } ,
        style: TextButton.styleFrom(
            primary: kPrimaryColor,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )
        ),
        child: Text(
          'Upgrade to PRO',
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

  Widget listBuilder()
  {
    return Container(
      child: FutureBuilder(
        future: searchUsersFomApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          if(snapshot.hasData)
            {
              users = snapshot.data;
            }
          else if(snapshot.hasError)
            {
              return Text('error ${snapshot.error}');
            }else{
            return Expanded(
              child: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return users.length > 0 ? membersList(users) : noUserFound();
        },
      ),
    );
  }

  Widget noUserFound()
  {
    if(_emailController.text.isEmpty)
      return Container();

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        'No user found!',
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Nunito',
              fontSize: 20
            )
        ),
      ),
    );
  }

  Future<List<User>> searchUsersFomApi() async
  {
    if(_emailController.text.isEmpty)
      return [];

    var result = await API_Manager.GetUsersByEmail(_emailController.text);
    return result.body!;
  }

  Widget membersList(List<User> users)
  {
    users.removeWhere((element) => element.email == CurrentLogin().user!.email);

    return Expanded(
      child: Container(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index)
            {
              return userCard(users[index]);
            }
        ),
      ),
    );
  }

  void showToast(Widget toast) {
    _toast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 3),
    );
  }


  Widget successToast(){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kSuccessToast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text('Invitation sent', style: kToastStyle)
          ],
        )
    );
  }

  Widget userCard(User user) {
    double _borderRadius = 4;

    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 8),
              child: Text(
                user.email,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: kTextOnSecondary,
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w700
                    )
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
              child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Invite',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: kSecondaryLightColor,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.add, color: kSecondaryLightColor)
                    ],
                  ),
                  onPressed: () {
                    print('Invite pressed');
                    _onInviteClick(
                        widget.workspace, user, CurrentLogin().user!);
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      )
                  )
              ),
            ),
          )
        ],
      ),
    );


    return Container(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: InkWell(
          splashColor: kPrimaryDarkColor.withAlpha(50),
          borderRadius: BorderRadius.circular(_borderRadius),
          onTap: () {

          },
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4, left: 8),
                    child: Text(
                      user.email,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: kTextOnSecondary,
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700
                          )
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
                    child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Invite',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: kSecondaryLightColor,
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.add, color: kSecondaryLightColor)
                          ],
                        ),
                        onPressed: () {
                          print('Invite pressed');
                          _onInviteClick(widget.workspace, user, CurrentLogin().user!);
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();

  Widget newMemberEmailField()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kSecondaryDarkColor,
      ),
      child: TextField(
        controller: _emailController,
        style: TextStyle(
            color: kTextOnSecondary,
            fontFamily: 'OpenSans'
        ),
        onChanged: (value){
          setState(() {
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.alternate_email,
            color: kTextOnSecondary,
          ),
          hintText: "Enter email",
          hintStyle: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'Nunito',
              )
          ),
        ),
      ),
    );
  }
}
