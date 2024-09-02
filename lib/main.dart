import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pdfreaderapp/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],

        // theme: ThemeData(
        //   hoverColor: Colors.blue,
        //   // textSelectionTheme: const TextSelectionThemeData(
        //   //     selectionColor: Color.fromARGB(255, 239, 207, 205),
        //   //     selectionHandleColor: Colors.blue),
        // ),
        home: const PDFScreen());
  }
}
