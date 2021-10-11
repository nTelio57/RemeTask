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

final API_Manager apiManager = API_Manager();

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task list'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Background(color: kSecondaryColor),
          taskList()
        ],
      ),
      bottomNavigationBar: BottomNavigationMenus(),
      floatingActionButton: BottomNavigationButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget taskList()
  {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder<List<TaskGroup>>(
        future: apiManager.TaskGroupsByUserId(CurrentLogin().user!.id),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
            {
              if(snapshot.hasError)
                {
                  print('kazkas blogai ');
                }

              List<TaskGroup> taskGroups = snapshot.data!;
              var sortedTasks = sortedTaskList(taskGroups);

              return Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: sortedTasks.length,
                  itemBuilder: (context, index)
                  {
                    var time = timeLeft(sortedTasks[index].deadline);
                    var colors = cardColors(sortedTasks[index].deadline.difference(DateTime.now()).inDays);
                    return TaskCard(title: sortedTasks[index].title, tag: sortedTasks[index].taskGroup!.tag, time: time[0], timeType: time[1], color: colors[0], fontColor: colors[1]);
                  },
                ),
              );
            }
          else
            {
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                  )
                ),
              );
            }
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

    if(daysLeft > 10){//green
      list[0] = kTaskGood;
      list[1] = kTextOnPrimary;
    }else if(daysLeft > 6){//yellow
      list[0] = kTaskMedium;
      list[1] = kTextOnPrimary;
    }else if(daysLeft > 2){//orange
      list[0] = kTaskBad;
      list[1] = kTextOnPrimary;
    }else{//red
      list[0] = kTaskVeryBad;
      list[1] = kTextOnPrimary;
    }
    return list;
  }

}
