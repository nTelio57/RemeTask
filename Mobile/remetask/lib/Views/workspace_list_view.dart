import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/invitation_list_view.dart';
import 'package:remetask/Views/workspace_read_view.dart';

FToast? _toast;

class WorkspaceListView extends StatefulWidget {
  const WorkspaceListView({Key? key}) : super(key: key);

  @override
  _WorkspaceListViewState createState() => _WorkspaceListViewState();
}

class _WorkspaceListViewState extends State<WorkspaceListView> {

  bool _isProcessingApiCall = false;
  List<Workspace> workspaces = [];
  CurrentLogin user = CurrentLogin();

  @override
  Widget build(BuildContext context) {

    _toast = FToast();
    _toast!.init(context);

    return SafeArea(
      child: Scaffold(
        body: body(),
        floatingActionButton: fabButton(),
      ),
    );
  }

  Widget fabButton(){
    return FloatingActionButton(
      onPressed: (){
        print('Create workspace clicked');
        showDialog(
            context: context,
            builder: (BuildContext context){
              return newWorkspaceDialog();
            }
        );
      },
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: kPrimaryColor,
    );
  }

  final TextEditingController _workspaceTitle = TextEditingController();

  Widget newWorkspaceDialog()
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
                      'New workspace',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: kTextOnPrimary,
                            fontSize: 32,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                  ),
                  Container(
                    child: newWorkspaceTitleForm(),
                    padding: EdgeInsets.fromLTRB(24, 20, 24, 10)
                  ),
                  Container(
                    child: newWorkspaceButtonForm(),
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

  Widget newWorkspaceTitleForm()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        controller: _workspaceTitle,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans'
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.create,
            color: Colors.grey[600],
          ),
          hintText: "Title",
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget newWorkspaceButtonForm()
  {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: ()  async {
          if(_isProcessingApiCall) return;

          _isProcessingApiCall = true;
          var newTaskGroup = await API_Manager.PostWorkspace(new Workspace(name: _workspaceTitle.text, owner: CurrentLogin().user!.id));
          if(newTaskGroup.statusCode == 201)
          {
            user.addWorkspace(newTaskGroup.body!);
            user.setSelectedWorkspace(newTaskGroup.body!);
          }else {
            showToast(failureToast('Failed to create workspace. ${newTaskGroup.statusCode} ${newTaskGroup.reasonPhrase}'));
          }

          setState(() {
            _isProcessingApiCall = false;
            _workspaceTitle.clear();
            Navigator.pop(context);
          });

        } ,
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )
        ),
        child: Text(
          'Create',
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

  void showToast(Widget toast) {
    _toast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 3),
    );
  }

  Widget failureToast(String text){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kFailureToast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text(text, style: kToastStyle)
          ],
        )
    );
  }

  Widget body()
  {
    var workspaces = CurrentLogin().workspaces;
    var invitations = CurrentLogin().invitations;

    return Stack(
      children: [
        Background(color: kSecondaryColor),
        Container(
          child: Column(
            children: [
              invitations.length > 0 ? invitationsBar(invitations.length) : Container(),
              Expanded(
                  child: listBuilder()
              ),
            ]
          ),
        )
      ],
    );
  }

  Widget invitationsBar(int invitationCount)
  {
    String ending = invitationCount == 1 ? '' : 's';
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$invitationCount Invitation request$ending',
              ),
              SizedBox(width: 10,),
              Icon(Icons.chevron_right, color: kPrimaryColor)
            ],
          ),
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => InvitationListView()));
          },
          style: TextButton.styleFrom(
              primary: kPrimaryColor,
              backgroundColor: kSecondaryLightColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              )
          )
      ),
    );
  }

  Widget noWorkspacesInfo()
  {
    return Container(
      color: kSecondaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add,
              color: kPrimaryColor,
              size: 32,
            ),
            Text(
              'Workspaces appear here when you create them.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Workspace>> getWorkspacesFromApi() async
  {
    var workspaces = await API_Manager.GetWorkspacesByUserId(user.user!.id);
    return workspaces.body!;
  }

  Widget listBuilder()
  {
    return Container(
      child: FutureBuilder(
        future: getWorkspacesFromApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          if(snapshot.hasData)
          {
            workspaces = snapshot.data;
            user.setWorkspaces(snapshot.data);
            user.setWorkspaceSet(true);
          }
          else if(snapshot.hasError)
          {
            return Text('error ${snapshot.error}');
          }else{

            if(user.workspaces.isNotEmpty && user.isWorkspaceSet())
                return workspaceList(user.workspaces);
            
            return Expanded(
              child: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return workspaces.length > 0 ? workspaceList(workspaces) : noWorkspacesInfo();
        },
      ),
    );
  }

  Widget workspaceList(List<Workspace> workspaces)
  {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          var workspaces = await getWorkspacesFromApi();
          user.setWorkspaces(workspaces);
          user.setWorkspaceSet(true);
          await user.loadInvitations();
          setState(() {

          });
        },
        child: ListView.builder(
          itemCount: workspaces.length,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemBuilder: (context, index)
          {
            return Column(
              children: [
                workspaceTab(workspaces[index]),
                SizedBox(height: 20,)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget workspaceTab(Workspace workspace)
  {
    return Container(
      color: kSecondaryLightColor,
      child: ExpansionTile(
        title: Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  workspace.name,
                  style: kWorkspaceCardLabel,
                ),
              ),
              user.getSelectedWorkspace()!.id == workspace.id ?
              Container(
                child: Text(
                  'SELECTED',
                  style: kWorkspaceSelectionNote,
                ),
                alignment: Alignment.centerRight,
              ) : Container()
            ],
          ),
        ),
        children: [
          Container(
            color: kPrimaryColor,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                //CurrentLogin().selectedWorkspace != workspace ? workspaceSelectionButton(workspace) : Container(),
                Row(
                  children: [
                    if(user.getSelectedWorkspace() != workspace) Expanded(child: workspaceSelectionButton(workspace)),
                    if(user.getSelectedWorkspace() != workspace) SizedBox(width: 10,),
                    Expanded(child: workspaceOpenButton(workspace))
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Total task count:', style: kWorkspaceCardExpansionPanel)),
                    Expanded(child: Container(alignment: Alignment.centerRight,child: Text(workspace.getTotalTaskCount().toString(), style: kWorkspaceCardExpansionPanel))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Deadlines:', style: kWorkspaceCardExpansionPanel)),
                    Expanded(child: Container(alignment: Alignment.centerRight,child: Text(workspace.getTotalDeadlineCount().toString(), style: kWorkspaceCardExpansionPanel))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Completed tasks:', style: kWorkspaceCardExpansionPanel)),
                    Expanded(child: Container(alignment: Alignment.centerRight,child: Text(workspace.getTotalCompletedCount().toString(), style: kWorkspaceCardExpansionPanel))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget workspaceOpenButton(Workspace workspace)
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 8),
      child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Open',
                style: kWorkspaceSelectionButton,
              ),
              SizedBox(width: 10,),
              Icon(Icons.chevron_right, color: kPrimaryColor)
            ],
          ),
          onPressed: () {
            print('Workspace open pressed');
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => WorkspaceReadForm(workspace: workspace)));
          },
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: kSecondaryLightColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              )
          )
      ),
    );
  }

  Widget workspaceSelectionButton(Workspace workspace)
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 8),
      child: TextButton(
          child: Text(
            'Set active',
            style: kWorkspaceSelectionButton,
          ),
          onPressed: () {
            print('Workspace select pressed');
            setState(() {
              CurrentLogin().setSelectedWorkspace(workspace);
            });
          },
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: kSecondaryLightColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              )
          )
      ),
    );
  }

}
