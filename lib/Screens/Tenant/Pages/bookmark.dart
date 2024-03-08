import 'dart:convert';

import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<dynamic> savedBoardings = [];

  @override
  void initState() {
    super.initState();
    
    fetchSavedBoardings(UserData.currentUser!.authToken);
  }

  Future<void> fetchSavedBoardings(String authToken) async {
  String apiUrl = 'http://192.168.239.100:8000/api/tenant/saved-boardings/';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Token $authToken', 
      },
    );

    if (response.statusCode == 200) {
      
      List<dynamic> savedBoardings = json.decode(response.body);
      
      print('Saved Boardings: $savedBoardings');
    } else {
      print('Failed to fetch saved boardings. Status code: ${response.statusCode}');
      
    }
    } catch (e) {
      print('Error fetching saved boardings: $e');
      
    }
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
