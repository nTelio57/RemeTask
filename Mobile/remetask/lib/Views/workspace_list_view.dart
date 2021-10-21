import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/workspace_read_view.dart';

class WorkspaceListView extends StatefulWidget {
  const WorkspaceListView({Key? key}) : super(key: key);

  @override
  _WorkspaceListViewState createState() => _WorkspaceListViewState();
}

class _WorkspaceListViewState extends State<WorkspaceListView> {
  @override
  Widget build(BuildContext context) {
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
        content: Wrap(
          children: [
            Container(
              child: Column(
                children: [
                  newWorkspaceTitleForm(),
                  SizedBox(height: 20,),
                  newWorkspaceButtonForm()
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
          print('New task group clicked');
          var newTaskGroup = await API_Manager.PostWorkspace(new Workspace(name: _workspaceTitle.text, owner: CurrentLogin().user!.id));
          if(newTaskGroup.statusCode == 201)
          {
            setState(() {
              CurrentLogin().addWorkspace(newTaskGroup.body!);
              CurrentLogin().setSelectedWorkspace(newTaskGroup.body!);
              Navigator.pop(context);
              _workspaceTitle.clear();
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

  Widget body()
  {
    var workspaces = CurrentLogin().workspaces;

    return Stack(
      children: [
        Background(color: kSecondaryColor),
        workspaceList(workspaces)
      ],
    );
  }

  Widget workspaceList(List<Workspace> workspaces)
  {
    return Container(
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
              CurrentLogin().selectedWorkspace == workspace ?
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
                    if(CurrentLogin().selectedWorkspace != workspace) Expanded(child: workspaceSelectionButton(workspace)),
                    if(CurrentLogin().selectedWorkspace != workspace) SizedBox(width: 10,),
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
