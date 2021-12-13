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
import 'package:remetask/Utilities/API_Response.dart';
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

  CurrentLogin user = CurrentLogin();
  int daysForDeadline = 5;
  Workspace? selectedWorkspace;
  List<Task> allTasks = [];
  List<Task> deadlines = [];
  List<Task> completed = [];

  @override
  Widget build(BuildContext context) {
    return tabController();
  }


  void setTaskLists()
  {
    selectedWorkspace = user.getSelectedWorkspace();
    allTasks = sortTaskList(selectedWorkspace!.taskGroups!);
    deadlines = sortTaskList(selectedWorkspace!.taskGroups!).where((task) => isDeadline(task, daysForDeadline)).toList();
    completed = sortTaskList(selectedWorkspace!.taskGroups!).where((task) => task.isCompleted!).toList();
  }

  Widget taskLoader()
  {
    selectedWorkspace = user.getSelectedWorkspace();

    return FutureBuilder(
      future: loadTasks(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
      {
        if(snapshot.hasData)
        {
          return workspaceInfo();
        }
        else if(snapshot.hasError)
        {
          return Container(
            color: Colors.red,
          );
        }
        else
        {
          if(selectedWorkspace != null && selectedWorkspace!.taskGroups!.isNotEmpty)
          {
            setTaskLists();
            return workspaceInfo();
          }

          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget tabController()
  { return DefaultTabController(
      length: 3,
      initialIndex: 0,//deadlines.length > 0 ? 1 : 0,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
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
        body : !user.hasAnyWorkspace() ? noWorkspacesInfo() :
        user.getSelectedWorkspace()!.taskGroups!.length > 0 ? taskLoader() : noTaskGroupInfo(),
        floatingActionButton: user.hasAnyWorkspace() ? fabButton() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget workspaceInfo()
  {
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
            deadlines.length > 0 ? taskList(deadlines) : noDeadlinesInfo()
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

  Future loadTasks() async
  {
    var selectedWorkspaceId = CurrentLogin().getSelectedWorkspaceId();
    if(selectedWorkspaceId != null)
      {
        if(user.getSelectedWorkspace() == null)
          {
            var selectedWorkspace = await API_Manager.GetWorkspace(selectedWorkspaceId);
            if(selectedWorkspace.statusCode == 200)
              {
                user.setWorkspaces([selectedWorkspace.body!]);
              }
          }

        var selectedWorkspaceTasks = await API_Manager.GetWorkspaceTaskGroups(selectedWorkspaceId);
        if(selectedWorkspaceTasks.statusCode == 200)
          {
            user.setSelectedWorkspaceTasks(selectedWorkspaceTasks.body!);

            setTaskLists();
          }
        return true;
      }

    return false;
  }

  Widget noDeadlinesInfo()
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'No deadlines for now.',
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
            Icon(
              Icons.sentiment_satisfied_alt,
              color: kPrimaryColor,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget noWorkspacesInfo()
  {
    return Container(
      color: kSecondaryColor,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_carousel,
              color: kPrimaryColor,
              size: 32,
            ),
            Text(
              'Begin by creating your first workspace and adding groups to it.',
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

  Widget noTaskGroupInfo()
  {
    return Container(
      color: kSecondaryColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_carousel,
              color: kPrimaryColor,
              size: 32,
            ),
            Text(
              'You need groups in your workspace to be able to create and store your tasks.',
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
      child: RefreshIndicator(
        onRefresh: () async {
          await loadTasks();
          setState(()  {

          });
        },
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
      for(var j = 0; j < taskGroups[i].tasks!.length; j++){
        taskGroups[i].tasks![j].taskGroup = taskGroups[i];
        tasks.add(taskGroups[i].tasks![j]);
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

