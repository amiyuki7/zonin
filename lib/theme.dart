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
      navigationBarTheme: const NavigationBarThemeData().copyWith(
        indicatorColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) => TextStyle(
            color:
                (states.contains(MaterialState.selected)) ? accentPurple2 : const Color(0xFF79747E),
            fontWeight:
                (states.contains(MaterialState.selected)) ? FontWeight.w900 : FontWeight.w600,
            height: 0,
            fontSize: 14,
          ),
        ),
      ),
    );
