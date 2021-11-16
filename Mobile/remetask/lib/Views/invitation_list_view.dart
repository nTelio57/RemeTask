import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Invitation.dart';
import 'package:remetask/Models/InvitationResponse.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

class InvitationListView extends StatefulWidget {
  const InvitationListView({Key? key}) : super(key: key);

  @override
  _InvitationListViewState createState() => _InvitationListViewState();
}

class _InvitationListViewState extends State<InvitationListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your invitations'),
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
        invitationsList()
      ],
    );
  }

  Widget invitationsList()
  {
    var invitations = CurrentLogin().invitations;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.builder(
          itemCount: invitations.length,
          itemBuilder: (context, index)
          {
            return invitationCard(invitations[index]);
          }
      ),
    );
  }

  Widget invitationCard(Invitation invitation)
  {
    double _borderRadius = 4;

    return Container(
      child: Card(
        //margin: EdgeInsets.all(0),
        elevation: 0,
        color: kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invitation.workspace!.name,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: kTextOnSecondary,
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600
                    )
                ),
              ),
              Text(
                'Invited by: ${invitation.inviter!.email} ',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: kTextOnSecondary,
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500
                    )
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Accept',
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.thumb_up_alt, color: Colors.white)
                          ],
                        ),
                        onPressed: () {
                          print('Accept invitations pressed');
                          _respondInvitation(invitation, true);
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reject',
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.thumb_down_alt, color: Colors.white)
                          ],
                        ),
                        onPressed: () {
                          print('Reject invitations pressed');
                          _respondInvitation(invitation, false);
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _respondInvitation(Invitation invitation, bool response) async
  {
    setState(() {
      CurrentLogin().removeInvitation(invitation);
    });
    var invitationResponse = new InvitationResponse(response, invitation.id!);
    await API_Manager.PostInvitationResponse(invitationResponse);
  }

}
