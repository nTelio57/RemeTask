import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Views/task_read_view.dart';

class TaskCard extends StatelessWidget {

  String? time, timeType;
  Color? color, fontColor;
  Task task;
  TaskCard({
    Key? key,
    required this.task
  }) : super(key: key);

  final double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    var times = timeLeft(task.deadline);
    time = times[0];
    timeType = times[1];

    var colors = cardColors(task.deadline.difference(DateTime.now()).inDays);
    color = colors[0];
    fontColor = colors[1];

    return taskCard(context);
  }

  Widget taskCard(BuildContext context)
  {
    DateFormat dateFormat = DateFormat("MM/dd HH:mm");

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green,
            Colors.red
          ]
        )
      ),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: InkWell(
          splashColor: kPrimaryDarkColor.withAlpha(50),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => TaskReadForm(task: task)));
          },
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Container(
            width: double.infinity,
            height: 75,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 7, right: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '|${task.taskGroup!.tag}| ',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis
                                    )
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Flexible(
                                child: Text(
                                  task.title,
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: kTextOnSecondary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis
                                      )
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:const EdgeInsets.only(left: 10, right: 10, bottom: 7),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 25,
                            child: Text(
                              '${dateFormat.format(task.deadline)}',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: kTextOnSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis
                                  )
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: task.isCompleted! ? kTaskGood : color,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: task.isCompleted! ?
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(
                          Icons.check,
                          size: 35,
                          color: Colors.white,
                        )
                      )
                          :
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 38,
                            child: Text(
                              time!,
                              style: kTaskCardTime,
                            ),
                          ),
                          Container(
                            child: Text(
                              timeType!,
                              style: kTaskCardTimeType,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
}
