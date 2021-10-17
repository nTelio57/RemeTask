import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remetask/Enums/PriorityType.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

class TaskReadForm extends StatefulWidget {
  Task task;
  TaskReadForm({Key? key, required this.task}) : super(key: key);

  @override
  _TaskReadFormState createState() => _TaskReadFormState();
}

class _TaskReadFormState extends State<TaskReadForm> {

  double _borderRadius = 22;
  DateFormat dateFormat = DateFormat("MM/dd/yyyy HH:mm");

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: readForm(),
    );
  }

  Widget readForm()
  {
    return Stack(
      children: [
        Background(color: kSecondaryColor),
        SingleChildScrollView(
          child: Column(
            children: [
              mainTab(),
              SizedBox(height: 20),
              longTab(longText(widget.task.description)),
            ],
          ),
        )
      ],
    );
  }

  Widget mainTab()
  {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.only(left: 22, right: 22),
      decoration: BoxDecoration(
          color: kSecondaryLightColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius))
      ),
      child: Column(
        children: [
          titleRow(),
          SizedBox(height: 40),
          tabRow(label(dateFormat.format(widget.task.deadline)), 'Deadline'),
          tabRow(label(widget.task.taskGroup!.name), 'Group'),
          tabRow(label(Priority.parseToString(widget.task.priority)), 'Priority')
        ],
      ),
    );
  }



  Widget tabRow(Widget child, String hint)
  {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(child: label(hint)),
            Expanded(child: Container(child: child,alignment: Alignment.centerRight), flex: 3)
          ],
        ),
      ),
    );
  }

  Widget titleRow()
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 60),
      child: Text(
        widget.task.title,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'Nunito',
                fontSize: 22,
                overflow: TextOverflow.ellipsis
            )
        ),
      ),
    );
  }

  Widget longTab(Widget child)
  {
    return Container(
      child: child,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
          color: kSecondaryLightColor,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))
      ),
    );
  }

  Widget label(String text)
  {
    return Container(
      child: Text(
        text,
        style: kTaskLabelFullColor,
      ),
    );
  }

  Widget longText(String text)
  {
    return Container(
      child: Text(
        text,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: kTextOnSecondary,
              fontFamily: 'Nunito',
              fontSize: 18,
            )
        ),
      ),
    );
  }

}
