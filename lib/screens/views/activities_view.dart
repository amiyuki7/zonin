import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/components/zonin_text_field.dart';
import 'package:zonin/state/activity/activity_bloc.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * (1 / 12);

    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) => GridView.builder(
        padding: EdgeInsets.symmetric(vertical: spacing / 2, horizontal: spacing),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
        ),
        itemCount: context.read<ActivityBloc>().activities.length + 1,
        itemBuilder: (context, int idx) {
          final activities = context.read<ActivityBloc>().activities;
          return Material(
            elevation: 4,
            color: cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            // idx = 0 is the add button which will always be top left of the grid view for
            // accessibility. otherwise, note that ActivityBloc.activities is ordered earliest to
            // latest in creation (i.e. the higher the `order` property is, the newer it is). we
            // access the elements in reverse order using `activities.length - idx` to render in an
            // order where the latest created activities are at the top
            child: (idx == 0)
                // Add Button
                ? InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: plusBg,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialog_context) => Dialog(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Material(
                              elevation: 10,
                              color: darkBg,
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          ZoninTextField(
                                            controller: nameController,
                                            labelText: 'NAME',
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please fill in this field';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 5),
                                          ZoninTextField(
                                            controller: descriptionController,
                                            labelText: 'DESCRIPTION',
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: focusText,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                          ),
                                          onPressed: () {
                                            _clearControllers();
                                            ScaffoldMessenger.of(dialog_context)
                                                .removeCurrentSnackBar();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: textColour,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color(0xFF8475C9),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              final activityBloc = context.read<ActivityBloc>();

                                              context.read<ActivityBloc>().add(
                                                    ActivityCreate(
                                                      nameController.text.trim(),
                                                      descriptionController.text.trim(),
                                                    ),
                                                  );

                                              final first = await activityBloc.stream.first;
                                              if (first is ActivityCreateSuccess) {
                                                _clearControllers();
                                                ScaffoldMessenger.of(dialog_context)
                                                    .removeCurrentSnackBar();
                                                Navigator.pop(dialog_context);
                                              } else if (first is ActivityCreateFail) {
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                    first.error,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w900,
                                                        color: darkBg2),
                                                  ),
                                                  backgroundColor: const Color(0xFFFF7477),
                                                );
                                                ScaffoldMessenger.of(dialog_context)
                                                    .removeCurrentSnackBar();
                                                ScaffoldMessenger.of(dialog_context)
                                                    .showSnackBar(snackBar);
                                                // Snackbar to show fail response
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Create',
                                            style: TextStyle(
                                              color: textColour,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activities[activities.length - idx].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: GoogleFonts.robotoCondensed().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 0,
                          ),
                        ),
                        Text(
                          activities[activities.length - idx].description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: GoogleFonts.robotoCondensed().copyWith(
                            fontSize: 13,
                            height: 0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '00:00:00',
                            style: GoogleFonts.robotoCondensed().copyWith(fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _clearControllers() {
    nameController.clear();
    descriptionController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }
}
