import 'package:flutter/material.dart';

import 'package:dad_jokes/services/joke_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _jokes = [];
  var _inProgress = false;

  void _addNewJoke() {
    setState(() => _inProgress = true);

    var joke = JokeService().queryRandomJoke();

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      joke
          .timeout(const Duration(seconds: 2))
          .then((value) => {
                if (value != null)
                  {
                    _jokes.insert(0, value),
                    if (_jokes.length > 20) {_jokes.removeLast()}
                  }
              })
          .whenComplete(() => {setState(() => _inProgress = false)});
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    var floatingActionButton = FloatingActionButton.extended(
      onPressed: _addNewJoke,
      backgroundColor: Colors.black,
      tooltip: 'New',
      label: const Text(
        'Generate',
        textScaleFactor: 1.2,
        style: TextStyle(color: Colors.white),
      ),
      icon: const Icon(Icons.replay, size: 32),
    );

    if (_inProgress) {
      floatingActionButton = FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Loading',
        child: const CircularProgressIndicator(value: null, color: Colors.black),
      );
    }

    return Scaffold(
      body: Scrollbar(
        child: ListView(
          restorationId: 'jokes-list-view',
          children: [
            for (int index = 0; index < _jokes.length; index++)
              ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(child: Text('${index + 1}')),
                ),
                shape: const Border(bottom: BorderSide(color: Colors.black12)),
                title: Text(_jokes.elementAt(index)),
              )
          ],
        ),
      ),
      floatingActionButton: floatingActionButton, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
