import 'package:flutter/material.dart';
import 'package:zonin/colors.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * (1 / 12);

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: spacing / 2, horizontal: spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: 5,
      itemBuilder: (context, int idx) {
        return Material(
          elevation: 4,
          color: cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: (idx == 0)
              // Add Button
              ? InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: plusBg,
                  onTap: () {},
                  child: const Center(
                    child: Material(
                      elevation: 4,
                      color: plusBg,
                      shape: CircleBorder(),
                      child: Icon(Icons.add, color: accentBlue, size: 60),
                    ),
                  ),
                )
              // Activity Cards
              : Placeholder(),
        );
      },
    );
  }
}
