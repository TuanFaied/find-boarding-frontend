// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String username;
  final String email;
  final String role;
  final String authToken;
  final int id;
  final String imageUrl;

  User({
    required this.username,
    required this.email,
    required this.role,
    required this.authToken,
    required this.id,
    required this.imageUrl,
  });
}

Future<void> signUpTenant(
    String username, String email, String password, String role) async {
  const String apiUrl = 'http://192.168.239.100:8000/api/auth/register/tenant/';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'user': {
        'username': username,
        'email': email,
        'role': role,
        'password': password,
      }
    }),
  );

  if (response.statusCode == 201) {
    
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(
        'User registered successfully: ${responseData["username"]}, ${responseData["email"]}, ${responseData["role"]}');
        
    
  } else {
    // Registration failed
    print('Failed to register user. ${response.body}');
    
    
  }
}

Future<void> signUpOwner(
    String username, String email, String password, String role) async {
  const String apiUrl = 'http://192.168.239.100:8000/api/auth/register/owner/';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'user': {
        'username': username,
        'email': email,
        'role': role,
        'password': password,
      }
    }),
  );

  if (response.statusCode == 201) {
    // Successful registration
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(
        'User registered successfully: ${responseData["username"]}, ${responseData["email"]}, ${responseData["role"]}');
    
    
  } else {
    
    print('Failed to register user. ${response.body}');
    
    
  }
}

String? authToken;

Future<User?> signIn(String username, String password) async {
  const String apiUrl = 'http://192.168.239.100:8000/api/auth/login/';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(
          'Login successful: ${responseData["username"]} ,${responseData['role']}');
      
      if (responseData['token'] != null && responseData['data'] != null) {
        print('hsdjahd');
       
        final userData = responseData['data'];
        User user = User(
          username: userData['user']['username'],
          email: userData['user']['email'],
          role: userData['user']['role'],
          authToken: responseData['token'],
          imageUrl: userData['user']['profile_image'],
          id: userData['user']['id'],
        );
        authToken = responseData['token'];
        print(authToken);
        return user;
      } 
      
      else {
        // Login failed
        print('Failed to login. ${response.body}');
        
        return null;
      }
    }
  } catch (e) {
    print('Error during login: $e');
    return null; 
  }
  return null;
}
