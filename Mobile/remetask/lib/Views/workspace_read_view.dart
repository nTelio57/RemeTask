import 'package:flutter/material.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

class WorkspaceReadForm extends StatefulWidget {

  Workspace workspace;

  WorkspaceReadForm({Key? key, required this.workspace}) : super(key: key);

  @override
  _WorkspaceReadFormState createState() => _WorkspaceReadFormState();
}

class _WorkspaceReadFormState extends State<WorkspaceReadForm> {
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
      child: Column(
        children: [
          Row(
            children: [
              newTaskGroupButton()
            ],
          ),
         SizedBox(height: 8),
         Expanded(child: taskGroupList())
        ],
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
          print('New task group clicked');
          var newTaskGroup = await API_Manager.PostTaskGroup(new TaskGroup(name: _taskGroupTitle.text, tag: _taskGroupTag.text, workspaceId: widget.workspace.id));
          if(newTaskGroup.statusCode == 201)
            {
              setState(() {
                widget.workspace.addTaskGroup(newTaskGroup.body!);
                Navigator.pop(context);
                _taskGroupTitle.clear();
                _taskGroupTag.clear();
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



  Widget membersBar()
  {
    return Container();
  }

}
