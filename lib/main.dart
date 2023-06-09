import 'package:dad_jokes/pages/home_page.dart';
import 'package:dad_jokes/pages/main.dart';
import 'package:dad_jokes/pages/second_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_messaging.dart' as messaging;
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => {messaging.listener()});
  runApp(const App());
}

class App extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final List<Function> routes = [
    () => const HomePage(),
    () => const SecondPage()
  ];

  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green),
      home: const MainPage(),
      navigatorKey: navigatorKey,
    );
  }
}
