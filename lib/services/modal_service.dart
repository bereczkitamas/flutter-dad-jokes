import 'package:dad_jokes/main.dart';
import 'package:flutter/material.dart';

class ModalService {
  static void showModal(String message) {
    showDialog(context: App.navigatorKey.currentContext!, builder: (_) =>
      AlertDialog(
        title: const Text('Notification'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(App.navigatorKey.currentContext!),
            child: const Text('Click'),
          )
        ],
      )
    );
  }
}