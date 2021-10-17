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
                TaskCreateForm()
              ],
            ),
            Stack(
              children: [
                Background(color: kSecondaryColor),
                taskListView()
              ],
            ),
            Stack(
              children: [
                Background(color: kSecondaryColor),
                taskListView()
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

  Widget taskListView()
  {
    CurrentLogin user = CurrentLogin();
    var sortedTasks = sortedTaskList(user.taskGroups!);

    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          child: taskList(sortedTasks),
        )
      ),
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
          var time = timeLeft(tasks[index].deadline);
          var colors = cardColors(tasks[index].deadline.difference(DateTime.now()).inDays);
          return TaskCard(title: tasks[index].title, tag: tasks[index].taskGroup!.tag, time: time[0], timeType: time[1], color: colors[0], fontColor: colors[1]);

        },
      ),
    );
  }

  List<Task> sortedTaskList(List<TaskGroup> taskGroups)
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

  List<String> timeLeft(DateTime deadline)
  {
    var list = <String>['',''];
    var diff =  deadline.difference(DateTime.now());
    if(diff.inDays > 1){
      list[0] = diff.inDays.toString();
      list[1] = 'days';
    }else{
      list[0] = diff.inHours.toString();
      list[1] = 'hours';
    }
    return list;
  }

  List<Color> cardColors(int daysLeft)
  {
    var list = <Color>[kTaskGood, kTextOnPrimary];

    if(daysLeft > 9){//good
      list[0] = kTaskGood;
      list[1] = kTextOnPrimary;
    }else if(daysLeft > 5){//medium
      list[0] = kTaskMedium;
      list[1] = kTextOnPrimary;
    }else if(daysLeft > 2){//bad
      list[0] = kTaskBad;
      list[1] = kTextOnPrimary;
    }else{//very bad
      list[0] = kTaskVeryBad;
      list[1] = kTextOnPrimary;
    }
    return list;
  }
}
