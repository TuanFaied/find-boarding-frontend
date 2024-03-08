import 'package:flutter/material.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginScreenTopImage(),
            // You can adjust the width or constraints of the form as needed
            SizedBox(
              width: 450,
              child: LoginForm(),
            ),
            // Include other widgets or components here
          ],
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const LoginForm(),
        ),
        
      ],
    );
  }
}
