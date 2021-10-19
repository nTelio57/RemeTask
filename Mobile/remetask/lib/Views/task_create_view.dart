import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:remetask/Components/TaskCreateFormComponents.dart';
import 'package:remetask/Enums/PriorityType.dart';
import 'package:remetask/Models/CurrentLogin.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';
import 'package:remetask/Utilities/API_Manager.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Utilities/globals.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TaskGroup? _selectedTaskGroup;
DateTime _selectedDate = DateTime.now();
double _selectedPriority = 3;

FToast? _toast;

class TaskCreateForm extends StatefulWidget {
  const TaskCreateForm({Key? key}) : super(key: key);

  @override
  State<TaskCreateForm> createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends State<TaskCreateForm> {

  double _borderRadius = 22;

  @override
  Widget build(BuildContext context) {

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedTaskGroup = null;
    _selectedDate = DateTime.now();
    _selectedPriority = 3;

    _toast = FToast();
    _toast!.init(context);

    return Scaffold(
      body: createForm(),
    );
  }

  Widget createForm(){
    print('TG ' + CurrentLogin().taskGroups!.length.toString());
    return Stack(
      children: [
        Background(color: kSecondaryColor),

        SingleChildScrollView(
          child: Column(
            children: [
              topTab(FormTextfield(hintText: 'Title', fontSize: 22, controller: _titleController)),
              SizedBox(height: 20),
              buttonTab(FormDatePicker()),
              SizedBox(height: 20),
              middleTab(FormDropdownList(items: CurrentLogin().taskGroups)),
              SizedBox(height: 20),
              middleTab(FormSlider()),
              SizedBox(height: 20),
              middleTab(FormTextfield(hintText: 'Description', expands: true, maxHeight: 150, minHeight: 50, controller: _descriptionController)),
              SizedBox(height: 80),
            ],
          ),
        ),
        confirmationButtons(),
      ],
    );
  }

  Widget topTab(Widget child)
  {
    return Container(
      height: 125,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryLightColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius))
      ),
      padding: EdgeInsets.symmetric(horizontal: 22),
      alignment: Alignment(-1,0.5),
      child: child,
    );
  }

  Widget middleTab(Widget child)
  {
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
          color: kSecondaryLightColor,
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))
      ),
    );
  }

  Widget buttonTab(Widget child)
  {
    return Container(
      child: child,
    );
  }

  Widget confirmationButtons()
  {
    double height = 60;
    return Align(
      alignment: Alignment(0,1),
      child: Container(
        height: height,
        color: kSecondaryColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                child: TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryDarkColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                child: TextButton(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryDarkColor
                    ),
                  ),
                  onPressed: () {
                    createTask();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTask() async
  {
    if(!validation())
      {
        return;
      }

    var title = _titleController.text;
    var description = _descriptionController.text;
    TaskGroup taskGroup = _selectedTaskGroup!;
    var deadline = _selectedDate;
    int selectedPriority = _selectedPriority.toInt();

    Task newTask = new Task(title, description, deadline, false, null, selectedPriority, null, taskGroup.id);

    await API_Manager.PostTask(newTask);
    await CurrentLogin().loadTaskGroups();
    showToast(successToast());
    Navigator.pop(context);
  }

  bool validation()
  {
    if(_titleController.text.isEmpty || _titleController.text == '')
      {
        showToast(failureToast('Make a title'));
        return false;
      }
    if(_selectedTaskGroup == null)
      {
        showToast(failureToast('Select a task group'));
        return false;
      }

    if(_selectedDate.compareTo(DateTime.now()) <= 0)
    {
      showToast(failureToast('A date has to be in a future'));
      return false;
    }
    return true;
  }

  Widget successToast(){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kSuccessToast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text('Task created', style: kToastStyle)
          ],
        )
    );
  }

  Widget failureToast(String text){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kFailureToast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text(text, style: kToastStyle)
          ],
        )
    );
  }

  void showToast(Widget toast) {
    _toast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 3),
    );
  }
}

//#region Date pick widget

class FormDatePicker extends StatefulWidget {
  final double borderRadius;

  FormDatePicker({
    Key? key,
    this.borderRadius = 22
  }) : super(key: key);

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {


  DateFormat dateFormat = DateFormat("MM/dd/yyyy HH:mm");
  var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      color: kSecondaryLightColor,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        splashColor: kPrimaryDarkColor.withAlpha(50),
        onTap: () {
          _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Expanded(child: label()),
              Expanded(child: dateTextfield())
            ],
          ),
        ),
      ),
    );
  }

  Widget dateTextfield()
  {
    return Container(
      child: Container(
        width: double.infinity,
        // height: 50,
        child: Center(
          child: Text(
              dateFormat.format(_selectedDate),
              style: kTaskLabelFullColor
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(currentDate.year, DateTime.january, 1),
        lastDate: DateTime(currentDate.year + 30, DateTime.december, 31));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectTime(context, picked);
      });
  }

  Future<void> _selectTime(BuildContext context, DateTime selectedDay) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate)
    );
    if (picked != null )
      setState(() {
        var newDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, picked.hour, picked.minute);
        _selectedDate = newDate;
      });
  }

  Widget label()
  {
    return Container(
      child: Text(
        'Deadline',
        style: kTaskLabelFullColor,
      ),
    );
  }

}

//#endregion

//#region Dropdown widget

class FormDropdownList extends StatefulWidget {

  static const List<TaskGroup> emptyList = [];

  final Color color;
  final String hintText;
  final List<TaskGroup>? items;

  FormDropdownList({
    Key? key,
    this.color = Colors.white,
    this.hintText = 'Group',
    this.items,
  }) : super(key: key);

  @override
  State<FormDropdownList> createState() => _FormDropdownListState();
}

class _FormDropdownListState extends State<FormDropdownList> {
  @override
  Widget build(BuildContext context) {
    return dropdownList();
  }

  Widget dropdownList()
  {
    return Container(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TaskGroup>(
          hint: Text(widget.hintText, style: kTaskCreateHintWithSize),
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              _selectedTaskGroup = newValue!;
            });
          },
          value: _selectedTaskGroup,
          items: widget.items!
              .map<DropdownMenuItem<TaskGroup>>((TaskGroup value) {
            return DropdownMenuItem<TaskGroup>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}

//#endregion

//#region Slider widget

class FormSlider extends StatefulWidget {
  double min;
  double max;

  FormSlider({
    Key? key,
    this.min = 1,
    this.max = 5
  }) : super(key: key);

  @override
  _FormSliderState createState() => _FormSliderState();
}

class _FormSliderState extends State<FormSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Text(
                'Priority',
                style: kTaskLabelFullColor,
              )),
          Expanded(child: slider(), flex: 2)
        ],
      ),
    );
  }

  Widget slider()
  {
    return Container(
      child: Slider(
        value: _selectedPriority,
        max: widget.max,
        min: widget.min,
        divisions: widget.max.toInt()-1,
        activeColor: kPrimaryColor,
        //label: _selectedPriority.toInt().toString(),
        label: Priority.parseToString(_selectedPriority.toInt()),
        onChanged: (value) {
          setState(() {
            _selectedPriority = value;
          });
        },
      ),
    );
  }
}

//#endregion