import 'package:flutter/material.dart';
import 'package:zonin/composition_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();

  // runApp(const MyApp());
  runApp(const Composer());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Zonin',
//       debugShowCheckedModeBanner: false,
//       theme: darkTheme(context),
//       // home: CompositionRoot.composeLoginUI(),
//       home: Composer(),
//     );
//   }
// }
