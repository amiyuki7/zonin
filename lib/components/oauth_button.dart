import 'package:flutter/material.dart';
import 'package:zonin/colors.dart';

class OAuthButton extends StatelessWidget {
  final Color bgColour;
  final String logoName;
  const OAuthButton({super.key, required this.logoName, this.bgColour = jetGray});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(60, 60),
          backgroundColor: bgColour,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset('assets/$logoName.png'),
      ),
    );
  }
}
