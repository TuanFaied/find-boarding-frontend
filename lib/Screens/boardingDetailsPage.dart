import 'package:carousel_slider/carousel_slider.dart';
import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:findboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoardingDetailsPage extends StatefulWidget {
  final Map<String, dynamic> boardingHouse;

  BoardingDetailsPage({required this.boardingHouse});

  @override
  _BoardingDetailsPageState createState() => _BoardingDetailsPageState();
}

class _BoardingDetailsPageState extends State<BoardingDetailsPage> {
  late final WebViewController controller;
  List<Map<String, dynamic>> images = [];
  bool isControllerInitialized = false;
  late List<int> savedBoardings;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    isControllerInitialized = false;
    savedBoardings = [];
  }

  void initializeController() {
    if (!isControllerInitialized) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.boardingHouse['location']));
      isControllerInitialized = true;
      fetchImages();
    }
  }

  Future<void> fetchImages() async {
    int boardingHouseId = widget.boardingHouse['id'];
    String apiUrl =
        'http://192.168.239.100:8000/api/boardings/$boardingHouseId/images';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          images = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> launchUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      Uri uri = Uri.parse(url);
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Future<void> saveRemoveBoarding() async {
    
    String apiUrl = 'http://192.168.239.100:8000/api/tenant/save-remove-boarding/${UserData.currentUser?.id}/';

    
    Map<String, dynamic> requestBody = {
      'saved_boardings': [widget.boardingHouse['id']],
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Token ${UserData.currentUser?.authToken}',
        },
      );

      if (response.statusCode == 200) {
        
        setState(() {
          isSaved = !isSaved;
        });
      } else {
        throw Exception('Failed to save/remove boarding');
      }
    } catch (e) {
      print('Error saving/removing boarding: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Boarding Details'),
        backgroundColor:kPrimaryColor ,
      ),
      backgroundColor: kPrimaryLightColor,
      body: SingleChildScrollView(
        
        physics: BouncingScrollPhysics(), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            
            images.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(image['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )
                : SizedBox.shrink(),
                SizedBox(height: 20,),
            Card(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Name of the Owner'),
                    subtitle: Text(widget.boardingHouse['owner']),
                  ),
                  ListTile(
                    title: Text('Address'),
                    subtitle: Text(widget.boardingHouse['address']),
                  ),
                  ListTile(
                    title: Text('University'),
                    subtitle: Text(widget.boardingHouse['university_name']),
                  ),
                  ListTile(
                    title: Text('Faculty'),
                    subtitle: Text(widget.boardingHouse['university_faculty']),
                  ),
                  ListTile(
                    title: Text('Number of Rooms'),
                    subtitle: Text(widget.boardingHouse['number_of_rooms'].toString()),
                  ),
                  ListTile(
                    title: Text('Number of Person'),
                    subtitle: Text(widget.boardingHouse['capacity_of_people'].toString()),
                  ),
                  ListTile(
                    title: Text('Rent'),
                    subtitle: Text(widget.boardingHouse['rent']),
                  ),
                  ListTile(
                    title: Text('Phone Number'),
                    subtitle: Text(widget.boardingHouse['phone_number'] ?? 'N/A'),
                  ),
                ],
              ),
            ),
            
            
            
            SizedBox(
              height: 500, 
              child: WebViewWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
