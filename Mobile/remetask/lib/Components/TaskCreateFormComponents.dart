import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class FormTextfield extends StatelessWidget {
  final String hintText;
  final double maxHeight;
  final double minHeight;
  final bool expands;
  final double fontSize;
  final Color color;
  TextEditingController? controller;

  FormTextfield({
    Key? key,
    this.hintText = '',
    this.expands = false,
    this.fontSize = 18,
    this.maxHeight = 150,
    this.minHeight = 70,
    this.color = Colors.white,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minHeight: expands ? minHeight : 0
        ),
        child: TextField(
          controller: controller,
          maxLines: expands ? null : 1,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: fontSize
          ),
          textAlignVertical: expands ? TextAlignVertical.top : TextAlignVertical.top,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: kTaskCreateHintNoSize,
            fillColor: Colors.red,
          ),
        ),
      ),
    );
  }

}
