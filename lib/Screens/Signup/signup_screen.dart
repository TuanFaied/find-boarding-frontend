import 'package:findboarding/constants.dart';
import 'package:flutter/material.dart';
import '../Signup/components/sign_up_top_image.dart';
import '../Signup/components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SignUpScreenTopImage(),
            
            SizedBox(
              width: 450,
              child: SignUpForm(),
            ),
            SizedBox(height: defaultPadding / 2),
            
          ],
        ),
      ),
    );
  }
}


class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SignUpScreenTopImage(),
        
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const SignUpForm(),
        ),
        const SizedBox(height: defaultPadding / 2),
        
      ],
    );
  }
}
