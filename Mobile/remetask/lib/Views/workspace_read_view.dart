import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/invitation_create_view.dart';

class WorkspaceReadForm extends StatefulWidget {

  Workspace workspace;

  WorkspaceReadForm({Key? key, required this.workspace}) : super(key: key);

  @override
  _WorkspaceReadFormState createState() => _WorkspaceReadFormState();
}

class _WorkspaceReadFormState extends State<WorkspaceReadForm> {

  bool _isProcessingApiCall = false;

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: body(),
        appBar: AppBar(
          title: Text(widget.workspace.name),
          backgroundColor: kSecondaryLightColor,
          foregroundColor: kPrimaryColor,
          bottom: TabBar(
            labelColor: kPrimaryColor,
            tabs: [
              Tab(
                text: 'Task groups' ,
              ),
              Tab(
                text: 'Members',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body()
  {
    return TabBarView(
      children: [
        Stack(
          children: [
            Background(color: kSecondaryColor,),
            taskGroupBar()
          ],
        ),
        Stack(
          children: [
            Background(color: kSecondaryColor,),
            membersBar()
          ],
        )
      ],
    );
  }

  Widget taskGroupBar()
  {
    return Container(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: () async {
          var result = await API_Manager.GetWorkspace(widget.workspace.id!);
          if(result.statusCode == 200)
            {
              widget.workspace = result.body!;
            }
          else{
            Navigator.pop(context);
          }
          setState(() {

          });
        },
        child: Column(
          children: [
            Row(
              children: [
                newTaskGroupButton()
              ],
            ),
           SizedBox(height: 8),
           Expanded(
             child:  widget.workspace.taskGroups!.length > 0 ? taskGroupList() : noTaskGroupsInfo()
           )
          ],
        ),
      ),
    );
  }

  Widget taskGroupCard(TaskGroup taskGroup)
  {
    return Container(
      color: kSecondaryLightColor,
      child: ExpansionTile(
        title: Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  taskGroup.name,
                  style: kWorkspaceCardLabel,
                ),
              ),
            ],
          ),
        ),
        children: [
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  print('Task group edit clicked');
                  },
                child: Icon(Icons.article, color: kSecondaryLightColor,),
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: kPrimaryColor,
                  backgroundColor: kPrimaryColor
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  print('Task group show tasks clicked');
                },
                child: Row(
                  children: [
                    Icon(Icons.edit, color: kSecondaryLightColor,),
                    Text('data')
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: kPrimaryColor,
                    backgroundColor: kPrimaryColor
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  print('Task group archive clicked');
                },
                child: Icon(Icons.archive_outlined, color: kSecondaryLightColor,),
                style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: kPrimaryColor,
                    backgroundColor: Colors.red
                ),
              ),
            ],
          )*/
        ],
      ),
    );
  }

  Widget taskGroupList()
  {
    return Container(
      child: ListView.builder(
          itemCount: widget.workspace.taskGroups!.length,
          itemBuilder: (context, index)
          {
            return taskGroupCard(widget.workspace.taskGroups![index]);
          }
          ),
    );
  }

  Widget newTaskGroupButton()
  {
    return Expanded(
      child: Container(
        child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add task group',
                  style: kSecondaryButtonLabel,
                ),
                SizedBox(width: 10,),
                Icon(Icons.add, color: kSecondaryLightColor)
              ],
            ),
            onPressed: () {
              print('New task group pressed');
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return newTaskGroupDialog();
                  }
                  );
            },
            style: kSecondaryButton
        ),
      ),
    );
  }

  final TextEditingController _taskGroupTitle = TextEditingController();
  final TextEditingController _taskGroupTag = TextEditingController();

  Widget newTaskGroupDialog()
  {
    return Container(
      child: AlertDialog(
        content: Wrap(
          children: [
            Container(
              child: Column(
                children: [
                  newTaskGroupTitleForm(),
                  SizedBox(height: 20,),
                  newTaskGroupTagForm(),
                  SizedBox(height: 20,),
                  newTaskGroupButtonForm()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newTaskGroupTitleForm()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        controller: _taskGroupTitle,
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

  Widget newTaskGroupTagForm()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        controller: _taskGroupTag,
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
          hintText: "Tag (Max 5 symbols)",
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget newTaskGroupButtonForm()
  {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: ()  async {
          if(_isProcessingApiCall) return;

          _isProcessingApiCall = true;
          var newTaskGroup = await API_Manager.PostTaskGroup(new TaskGroup(name: _taskGroupTitle.text, tag: _taskGroupTag.text, workspaceId: widget.workspace.id));
          if(newTaskGroup.statusCode == 201)
            {
              setState(() {
                _isProcessingApiCall = false;
                widget.workspace.addTaskGroup(newTaskGroup.body!);
                _taskGroupTitle.clear();
                _taskGroupTag.clear();
                Navigator.pop(context);
              });
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

  Widget noTaskGroupsInfo()
  {
    return Container(
      color: kSecondaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add,
              color: kPrimaryColor,
              size: 32,
            ),
            Text(
              'You need groups to store your tasks.',
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


  Widget membersBar()
  {
    return Container(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: () async {
          var result = await API_Manager.GetUsersByWorkspace(widget.workspace.id!);
          widget.workspace.users = result.body;
          setState(() {

          });
        },
        child: Column(
          children: [
            Row(
              children: [
                newMemberButton()
              ],
            ),
            SizedBox(height: 8),
            Expanded(
                child: membersList()
            )
          ],
        ),
      ),
    );
  }

  Widget membersList()
  {
    var members = widget.workspace.users!;
    return Container(
      child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index)
          {
            return memberCard(members[index]);
          }
      ),
    );
  }

  Widget memberCard(User user)
  {
    double _borderRadius = 4;

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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Text(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newMemberButton()
  {
    return Expanded(
      child: Container(
        child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invite members',
                  style: kSecondaryButtonLabel,
                ),
                SizedBox(width: 10,),
                Icon(Icons.person_add, color: kSecondaryLightColor)
              ],
            ),
            onPressed: () {
              print('New member pressed');
              Navigator.push(context, new MaterialPageRoute(builder: (context) => InvitationCreateView(workspace: widget.workspace,)));
            },
            style: kSecondaryButton
        ),
      ),
    );
  }

  Widget newMemberDialog()
  {
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: kPrimaryColor,
      content: Container(
        color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                newMemberEmailForm(),
                newMemberButtonForm()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget newMemberEmailForm()
  {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kSecondaryLightColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _taskGroupTitle,
        style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'OpenSans'
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.alternate_email,
            color: kPrimaryColor,
          ),
          hintText: "Email",
          hintStyle: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'Nunito',
              )
          ),
        ),
      ),
    );
  }

  Widget newMemberButtonForm()
  {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: ()  async {
          if(_isProcessingApiCall) return;

          _isProcessingApiCall = true;
          var newTaskGroup = await API_Manager.PostTaskGroup(new TaskGroup(name: _taskGroupTitle.text, tag: _taskGroupTag.text, workspaceId: widget.workspace.id));
          if(newTaskGroup.statusCode == 201)
          {
            setState(() {
              _isProcessingApiCall = false;
              widget.workspace.addTaskGroup(newTaskGroup.body!);
              _taskGroupTitle.clear();
              _taskGroupTag.clear();
              Navigator.pop(context);
            });
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

}
