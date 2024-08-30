import 'package:flutter/material.dart';
import 'package:pdfreaderapp/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        // theme: ThemeData(
        //   hoverColor: Colors.blue,
        //   // textSelectionTheme: const TextSelectionThemeData(
        //   //     selectionColor: Color.fromARGB(255, 239, 207, 205),
        //   //     selectionHandleColor: Colors.blue),
        // ),
        home: PDFScreen());
  }
}
