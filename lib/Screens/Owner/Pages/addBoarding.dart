// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:findboarding/Screens/Owner/Pages/addNewBoarding.dart';
import 'package:findboarding/Screens/boardingDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddBoarding extends StatefulWidget {
  const AddBoarding({super.key});

  @override
  State<AddBoarding> createState() => _AddBoardingState();
}

class _AddBoardingState extends State<AddBoarding> {
  late Future<List<Map<String, dynamic>>> boardingHouses;
  @override
  void initState() {
    super.initState();
    boardingHouses = fetchBoardingHouses();
  }

  Future<List<Map<String, dynamic>>> fetchBoardingHouses() async {
    final response = await http.get(
      Uri.parse('http://192.168.239.100:8000/api/owner/boarding-houses/'),
      headers: {
        'Authorization': 'Token ${UserData.currentUser?.authToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load boarding houses');
    }
  }

  Future<String?> fetchFirstBoardingHouseImage(int? boardingHouseId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.239.100:8000/api/boardings/$boardingHouseId/images'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[0]['image'] as String;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 240, 182, 102),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10,top: 20),
          child: Text(
            'My Boarding Details',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: boardingHouses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No boarding houses available.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final boardingHouse = snapshot.data![index];

                    return GestureDetector(
                      onTap: () async {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardingDetailsPage(
                              boardingHouse: boardingHouse,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String?>(
                              future: fetchFirstBoardingHouseImage(boardingHouse['id']),
                              builder: (context, imageSnapshot) {
                                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (imageSnapshot.hasError) {
                                  return Text('Error: ${imageSnapshot.error}');
                                } else {
                                  final String? firstImage = imageSnapshot.data;
                                  print('First Image: $firstImage');
                                  print('id ${boardingHouse['id']}');
                                  return firstImage != null
                                      ? Image.network(
                                    firstImage,
                                    width: double.infinity,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(); 
                                }
                              },
                            ),
                            ListTile(
                              title: Text('${boardingHouse['university_name']}'),
                              subtitle: Text('${boardingHouse['university_faculty']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Rent: ${boardingHouse['rent']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                  'Number of Rooms: ${boardingHouse['number_of_rooms']}'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 129, 243, 133),
      onPressed: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddNewBoardingPage(),
          ),
        );
      },
      child: const Icon(Icons.add),
    ),
    floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
  );
}
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    
    return Offset(300.0, scaffoldGeometry.scaffoldSize.height - 120.0);
  }
}
