import 'package:flutter/material.dart';
import 'package:zonin/composition_root.dart';
import 'package:zonin/screens/login_screen.dart';
import 'package:zonin/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zonin',
      debugShowCheckedModeBanner: false,
      theme: darkTheme(context),
      home: CompositionRoot.composeLoginUI(),
    );
  }
}
