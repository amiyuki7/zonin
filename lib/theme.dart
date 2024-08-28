import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zonin/colors.dart';

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      primaryColor: accentPurple,
      scaffoldBackgroundColor: darkBg,
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).apply(
        displayColor: textColour,
        bodyColor: textColour,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: const IconThemeData(color: accentPurple),
    );
