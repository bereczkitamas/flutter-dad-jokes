import 'dart:io';

import 'dart:convert' as convert;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;

class JokeService {
  Future<String?> queryRandomJoke() async {
    var url = Uri.https('icanhazdadjoke.com');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {HttpHeaders.acceptHeader: 'application/json'});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      FirebaseAnalytics.instance.logEvent(name: 'new_joke', parameters: { 'a': 'b' });
      return jsonResponse['joke'];
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }

    return null;
  }
}