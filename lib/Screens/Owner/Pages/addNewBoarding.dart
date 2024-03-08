

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddNewBoardingPage extends StatefulWidget {
  const AddNewBoardingPage({Key? key}) : super(key: key);

  @override
  _AddNewBoardingPageState createState() => _AddNewBoardingPageState();
}

class _AddNewBoardingPageState extends State<AddNewBoardingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController loctionurlController = TextEditingController();
  TextEditingController noPersonController = TextEditingController();


  List<File?> selectedImages = [];

  void addBoarding() async {
    const url = 'http://192.168.239.100:8000/api/owner/boarding-houses/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Token ${UserData.currentUser?.authToken}';
      
      request.fields['owner'] = nameController.text;
      request.fields['rent'] = rentController.text;
      request.fields['number_of_rooms'] = roomsController.text;
      request.fields['address'] = addressController.text;
      request.fields['university_name'] = universityController.text;
      request.fields['university_faculty'] = facultyController.text;
      request.fields['location'] = loctionurlController.text;
      request.fields['phone_number'] = phoneController.text;
      request.fields['capacity_of_people'] = noPersonController.text;
      
      for (int i = 0; i < selectedImages.length; i++) {
      if (selectedImages[i] != null) {
        request.files.add(
          http.MultipartFile(
            'images',
            selectedImages[i]!.readAsBytes().asStream(),
            selectedImages[i]!.lengthSync(),
            filename: 'image$i.jpg',
          ),
        );
      }
    }
      var response = await request.send();
      if (response.statusCode == 201) {
        
        print('Boarding created successfully');
        print('Response: ${await response.stream.bytesToString()}');
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Boarding created successfully'),
          backgroundColor: Colors.green,
        ),
      );
      } else {
        
        print('Failed to create boarding');
        print('Response: ${await response.stream.bytesToString()}');
        
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create boarding'),
          backgroundColor: Colors.red,
        ),
      );
        
      }
    } catch (error) {
      
      print('Error: $error');
      
    }
  }

  Future<void> pickImages() async {
    
    List<XFile>? images = await ImagePicker().pickMultiImage();
    List<File?> imageFiles = images.map((image) => File(image.path)).toList();

    setState(() {
      selectedImages = imageFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Boarding Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'User Name',border: OutlineInputBorder(),),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: rentController,
              decoration: const InputDecoration(labelText: 'Rent',border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: roomsController,
              decoration: const InputDecoration(labelText: 'Number of Rooms',border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: noPersonController,
              decoration: const InputDecoration(labelText: 'Number of person',border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address',border: OutlineInputBorder(),),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: universityController,
              decoration: const InputDecoration(labelText: 'University Name',border: OutlineInputBorder(),),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: facultyController,
              decoration: const InputDecoration(labelText: 'Faculty Name',border: OutlineInputBorder(),),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: loctionurlController,
              decoration: const InputDecoration(labelText: 'Location',border: OutlineInputBorder(),),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number',border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: pickImages,
              
              style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 171, 36),
                    fixedSize: const Size(150, 50) ,
                    
                  ),
              child: const Text('Pick Images'),
            ),
            const SizedBox(height: 16.0),
            if (selectedImages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Images:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  
                  for (File? image in selectedImages)
                    image != null
                    ? Image.file(
                        image,
                        width: 100.0, 
                        height: 100.0, 
                        fit: BoxFit.cover,
                      )
                    : const Text('No Image Selected'),
                  const SizedBox(height: 16.0),
                ],
              ),
            ElevatedButton(
              onPressed: addBoarding,
              child: const Text('Add Boarding'),
            ),
          ],
        ),
      ),
    ),
  );
}

}


