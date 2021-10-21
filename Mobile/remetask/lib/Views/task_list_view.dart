import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Components/BottomNavigation.dart';
import 'package:remetask/Components/TaskCard.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Models/Workspace.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';
import 'package:remetask/Views/task_create_view.dart';

final API_Manager apiManager = API_Manager();

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {


    CurrentLogin user = CurrentLogin();



    return DefaultTabController(
      length: 3,
      initialIndex: 1,
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            //title: Text('Task list'),
            backgroundColor: kSecondaryLightColor,
            foregroundColor: kPrimaryColor,
            centerTitle: true,
            bottom: TabBar(
              labelColor: kPrimaryColor,
              tabs: [
                Tab(
                  text: 'ALL TASKS' ,
                ),
                Tab(
                  text: 'DEADLINES',
                ),
                Tab(
                  text: 'COMPLETED',
                ),
              ],
            ),
          ),
          body: user.hasAnyWorkspace() ? workspaceInfo() : noWorkspacesInfo(),
          floatingActionButton: fabButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
    );
  }

  Widget workspaceInfo()
  {
    int daysForDeadline = 5;
    CurrentLogin user = CurrentLogin();
    var selectedWorkspace = user.getSelectedWorkspace();
    var allTasks = sortTaskList(selectedWorkspace.taskGroups);
    var deadlines = sortTaskList(selectedWorkspace.taskGroups).where((task) => isDeadline(task, daysForDeadline)).toList();
    var completed = sortTaskList(selectedWorkspace.taskGroups).where((task) => task.isCompleted!).toList();

    return TabBarView(
      children: [
        Stack(
          children: [
            Background(color: kSecondaryColor),
            taskList(allTasks)
          ],
        ),
        Stack(
          children: [
            Background(color: kSecondaryColor),
            taskList(deadlines)
          ],
        ),
        Stack(
          children: [
            Background(color: kSecondaryColor),
            taskList(completed)
          ],
        ),
      ],
    );
  }


  Widget noWorkspacesInfo()
  {
    return Container(
      color: Colors.green,
    );
  }

  Widget fabButton(){
    return FloatingActionButton(
      onPressed: (){
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => TaskCreateForm())).then((value) => setState(() {}));
      },
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: kPrimaryColor,
    );
  }

  Widget taskList(List<Task> tasks)
  {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: tasks.length,
        itemBuilder: (context, index)
        {
          return Container(
            margin: EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  if(direction == DismissDirection.endToStart)
                    {
                      return await showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Confirm'),
                              content: Text('Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                )
                              ],
                            );
                          });
                    }
                  if(direction == DismissDirection.startToEnd)
                    {
                      return true;
                    }
                },
                background: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),


                secondaryBackground: Container(
                  decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  alignment: Alignment.centerRight,
                ),


                child: TaskCard(task: tasks[index]),
                key: UniqueKey(),
                onDismissed: (direction)
                {
                  if(direction == DismissDirection.endToStart)
                  {
                    setState(() {
                      int taskId = tasks[index].id!;
                      int taskGroupId = tasks[index].taskGroupId!;
                      // OLD VERSION CurrentLogin().removeTaskFromList(taskId, taskGroupId);
                      deleteTask(taskId);
                    });
                  }
                  if(direction == DismissDirection.startToEnd)
                    {
                      setState(() {
                        completeTask(tasks[index]);
                      });
                    }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future confirmTaskDelete()
  {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Delete title'),
            content: Text('Delete context'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  List<Task> sortTaskList(List<TaskGroup> taskGroups)
  {
    var tasks = <Task>[];
    for(var i = 0; i < taskGroups.length; i++){
      for(var j = 0; j < taskGroups[i].tasks.length; j++){
        taskGroups[i].tasks[j].taskGroup = taskGroups[i];
        tasks.add(taskGroups[i].tasks[j]);
      }
    }
    tasks.sort((a,b) => a.deadline.compareTo(b.deadline));
    return tasks;
  }

  bool isDeadline(Task task, int deadlineDaysThreshold)
  {
    var timeLeft =  task.deadline.difference(DateTime.now());
    if(timeLeft.inDays <= deadlineDaysThreshold && !task.isCompleted!)
      return true;
    return false;
  }

  void deleteTask(int taskId) async
  {
    await API_Manager.DeleteTask(taskId);
  }

  Future completeTask(Task task) async
  {
    task.isCompleted = true;
    task.completionDate = DateTime.now();

    await API_Manager.UpdateTask(task.id!, task);
    // OLD VERSION await CurrentLogin().loadTaskGroups();
  }
}

