import 'package:flutter/material.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/Workspace.dart';
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
          itemCount: widget.workspace.taskGroups.length,
          itemBuilder: (context, index)
          {
            return taskGroupCard(widget.workspace.taskGroups[index]);
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
            },
            style: kSecondaryButton
        ),
      ),
    );
  }



  Widget membersBar()
  {
    return Container();
  }

}
