
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//const kPrimaryColor = Color.fromRGBO(9, 169, 244, 1);
//const kSecondaryColor = Color.fromRGBO(220, 220, 220, 1);

//deep purple theme
/*const kPrimaryColor = Color(0xFF673AB7);
const kPrimaryLightColor = Color(0xFFD1C4E9);
const kPrimaryDarkColor = Color(0xFF512DA8);*/

//light blue theme
const kPrimaryColor = Color(0xFF0476bd);
const kPrimaryLightColor = Color(0xFF0288D1);
const kPrimaryDarkColor = Color(0xFF03569b);

const kSecondaryColor = Color.fromRGBO(235, 235, 235, 1);//Color(0xFFdcdcdc);
const kSecondaryLightColor = Colors.white;
const kSecondaryDarkColor = Color.fromRGBO(200, 200, 200, 1);

const kTextOnPrimary = Colors.white;
const kTextOnSecondary = Color(0xFF212121);

//const kComplementaryColor = Color.fromRGBO(244, 83, 9, 1);
//const kComplementaryColor = Color(0xFFf44f03);
const kComplementaryColor = Color(0xFFbd4b04);

const kIconColor = Color(0xFF757575);
const kHintColor = Color(0xFF757575);

const kTaskGood = Color(0xFF00BF3D);//Color(0xFF00BF3D);
const kTaskMedium = Color(0xFFFF910A);//Color(0xFFFF910A);
const kTaskBad = Color(0xFFC23455);//Color(0xFFC23455);
const kTaskVeryBad = Color(0xFFC23455);//Color(0xFF6F051D);

const kSuccessToast = Color(0xFF00BF3D);
const kFailureToast = Color(0xFFC23455);

final kHintTextStyle = TextStyle(
  color: Colors.grey[600],
  fontFamily: 'Nunito',
);

final kToastStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnPrimary,
        fontFamily: 'Nunito',
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500
    )
);

final kBottomConfirmationButtonStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnSecondary,
        fontFamily: 'Nunito',
        fontSize: 20,
    )
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kSecondaryButtonLabel = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kSecondaryLightColor,
        fontFamily: 'Nunito',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold
    )
);

final kSecondaryButton = TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
    )
);




final kWorkspaceCardLabel = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kPrimaryDarkColor,
        fontFamily: 'Nunito',
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold
    )
);

final kWorkspaceCardExpansionPanel = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnPrimary,
        fontFamily: 'Nunito',
        fontSize: 16,
        overflow: TextOverflow.ellipsis
    )
);

final kWorkspaceSelectionNote = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kPrimaryDarkColor,
        fontFamily: 'Nunito',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold
    )
);

final kWorkspaceSelectionButton = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kPrimaryColor,
        fontFamily: 'Nunito',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold
    )
);

final kTaskLabelFullColor = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnSecondary,
        fontFamily: 'Nunito',
        fontSize: 18,
        overflow: TextOverflow.ellipsis
    )
);

final kTaskCreateHintNoSize = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kHintColor,
        fontFamily: 'Nunito',
        //fontSize: 18,
        overflow: TextOverflow.ellipsis
    )
);

final kTaskCreateHintWithSize = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kHintColor,
        fontFamily: 'Nunito',
        fontSize: 18,
        overflow: TextOverflow.ellipsis
    )
);

final kTaskCardTitle = GoogleFonts.nunito(
    textStyle: TextStyle(
      color: kTextOnSecondary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 18,
      overflow: TextOverflow.ellipsis
    )
);

final kTaskCardTag = GoogleFonts.nunito(
    textStyle: TextStyle(
      color: kTextOnSecondary,
      fontWeight: FontWeight.w800,
      fontFamily: 'Nunito',
      fontSize: 16,
      overflow: TextOverflow.ellipsis
    )
);

final kTaskCardTime = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnPrimary,
        fontSize: 35,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
    )
);

final kTaskCardTimeType = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: kTextOnPrimary,
        fontSize: 15,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
    )
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