import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String accessToken;
  final String? refreshToken;

  User({
    required this.username,
    required this.accessToken,
    this.refreshToken,
  });
}

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;
  String? get username => _user?.username;
  String? get accessToken => _user?.accessToken;
  String? get refreshToken => _user?.refreshToken;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/rest-auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final username = responseData['user']['username'];
      final token = responseData['key'];

      if (username != null && token != null) {
        _user = User(
          username: username,
          accessToken: token,
        );
        notifyListeners();
      } else {
        throw Exception('Failed to get user data');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    // Your logout implementation code here
  }

  Future<void> signup(String email, String password) async {
    final username = email.split('@')[0];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/rest-auth/registration/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password1': password,
        'password2': password,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final username = responseData['username'];
      final accessToken = responseData['access_token'];

      if (username != null && accessToken != null) {
        _user = User(
          username: username,
          accessToken: accessToken,
        );
        notifyListeners();
      } else {
        throw Exception('Failed to get user data');
      }
    } else {
      throw Exception('Failed to signup');
    }
  }
}
