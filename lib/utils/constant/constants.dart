import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const_color.dart';



ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: EdgeInsets.symmetric(vertical: 16.0),
  textStyle: TextStyle(color: Colors.white, fontSize: 18),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

const double kMaxMobileWidth = 420.0;



final TextStyle kHeadingTextStyle = GoogleFonts.cherrySwash(
  textStyle: TextStyle(
    color: kPrimaryColor,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  ),
);

final TextStyle kInputLabelStyle = GoogleFonts.exo(
  textStyle: TextStyle(
    fontSize: 14,
    color: kPrimaryColor,
    fontWeight: FontWeight.w600,
  ),
);
