import 'dart:io';

import 'package:dio/dio.dart';
import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final bool isedit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isedit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final ImagePicker _picker = ImagePicker();

  late File? _image;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
  final image = NetworkImage(widget.imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          if (widget.isedit) {
            await pickImage();
          } else {
            widget.onClicked();
          }
        },
        child: Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
      ),
    ),
  );
}



  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            widget.isedit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Handle image upload logic here
      await updateProfileImage(_image!);
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(imageFile.path),
      });
      print('Token: ${UserData.currentUser?.authToken}');
      await dio.post('http://192.168.239.100:8000/api/user/update-profile-image/', data: formData,options: Options(
        headers: {
          'Authorization': 'Token ${UserData.currentUser?.authToken}',
        },
      ),);

      
    } catch (error) {
      print('Error updating profile image: $error');
      
    }
  }
}
