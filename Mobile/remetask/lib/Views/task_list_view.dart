import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remetask/Components/BottomNavigation.dart';
import 'package:remetask/Components/TaskCard.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';
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

    int daysForDeadline = 5;
    CurrentLogin user = CurrentLogin();
    var allTasks = sortTaskList(user.taskGroups!);
    var deadlines = sortTaskList(user.taskGroups!).where((task) => isDeadline(task, daysForDeadline)).toList();
    var completed = sortTaskList(user.taskGroups!).where((task) => task.isCompleted!).toList();

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
        body: TabBarView(
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
        ),
        bottomNavigationBar: BottomNavigationMenus(),
        floatingActionButton: fabButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      backgroundColor: kComplementaryColor,
    );
  }

  Widget taskList(List<Task> tasks)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemCount: tasks.length,
          itemBuilder: (context, index)
          {
            return TaskCard(task: tasks[index]);
          },
        ),
      ),
    );
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
}
