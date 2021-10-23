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

  double _insetLeft = 22;
  double _insetRight = 22;
  double _insetHorizontal = 22;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: readForm(),
    );
  }

  //#region Form

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
      decoration: BoxDecoration(
          color: kSecondaryLightColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius))
      ),
      child: Wrap(

        children: [
          Column(
            children: [
              titleRow(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    tabRow(label(dateFormat.format(widget.task.deadline)), 'Deadline'),
                    tabRow(longText(widget.task.taskGroup!.name, textAlign: TextAlign.right), 'Group'),
                    tabRow(label(Priority.parseToString(widget.task.priority)), 'Priority'),
                    widget.task.isCompleted! ? tabRow(label(dateFormat.format(widget.task.completionDate!)), 'Completed on') : Container()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }



  Widget tabRow(Widget child, String hint)
  {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: _insetLeft, right: _insetRight, top: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(child: label(hint)),
            Expanded(child: Container(child: child,alignment: Alignment.centerRight))
          ],
        ),
      ),
    );
  }

  Widget titleRow()
  {
    return Container(
      width: double.infinity,
      color: kPrimaryColor,
      padding: EdgeInsets.only(top: 60, left: _insetLeft, right: _insetRight, bottom: 15),
      child: Text(
        widget.task.title,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kTextOnPrimary,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                fontSize: 26,
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kTextOnSecondary,
                fontFamily: 'Nunito',
                fontSize: 16,
                overflow: TextOverflow.ellipsis
            )
        ),
      ),
    );
  }

  Widget longText(String text, {TextAlign textAlign = TextAlign.left})
  {
    return Container(
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: kTextOnSecondary,
              fontFamily: 'Nunito',
              fontSize: 16,
            )
        ),
      ),
    );
  }

//#endregion


}
