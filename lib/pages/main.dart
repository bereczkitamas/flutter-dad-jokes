import 'package:dad_jokes/main.dart';
import 'package:flutter/material.dart';

import '../components/navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Widget actualBody = App.routes.elementAt(0)();

  void changeInnerPage(int numberOfPage) {
    setState(() {
      actualBody = App.routes.elementAt(numberOfPage)() ?? actualBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appNavigationBar = AppNavigationBar(onTap: (value) => changeInnerPage(value));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Dad-Jokes Generator'),
      ),
      body: actualBody,
      bottomNavigationBar: appNavigationBar, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}