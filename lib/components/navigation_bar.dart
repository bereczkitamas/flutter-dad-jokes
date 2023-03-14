import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key, this.onTap});

  final ValueChanged<int>? onTap;

  @override
  State<StatefulWidget> createState() => _AppNavigationBarState();

}

class _AppNavigationBarState extends State<AppNavigationBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (value) => {
        setState(() {
          currentIndex = value;
        }),
        widget.onTap?.call(value)
      },
    );
  }
}