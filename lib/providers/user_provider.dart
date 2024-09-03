import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _username;

  UserProvider() {
    _fetchUser();
  }

  // Fetch the user and cache the data
  Future<void> _fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('name')) {
      _username = prefs.getString('name');
    } else {
      _username = "Unknown User";
    }
    notifyListeners(); // Notify listeners whenever user data is fetched or updated
  }

  String get username => _username ?? "Unknown User";
}
