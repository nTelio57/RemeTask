
import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(9, 169, 244, 1);
const kSecondaryColor = Color.fromRGBO(230, 230, 230, 1);
const kSecondaryLightColor = Colors.white;

const kTextOnPrimary = Colors.white;
const kTextOnSecondary = Colors.white;

final kHintTextStyle = TextStyle(
  color: Colors.grey[600],
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: new Color.fromRGBO(230, 230, 230, 1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);