
import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(9, 169, 244, 1);
const kSecondaryColor = Color.fromRGBO(220, 220, 220, 1);
const kSecondaryLightColor = Colors.white;

const kTextOnPrimary = Colors.white;
const kTextOnSecondary = Colors.black;

const kComplementaryColor = Color.fromRGBO(244, 83, 9, 1);

const kIconColor = Color(0xFF757575);

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