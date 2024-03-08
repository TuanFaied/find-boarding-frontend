import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../../../auth/authentication.dart';
import '../../Tenant/tenantHomePage.dart';
import '../../Owner/ownerHomePage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5, horizontal: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Your username",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              
              if (_formKey.currentState?.validate() ?? false) {
                
                signInAndNavigate();
              }
            },
            child: Text("Login".toUpperCase()),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: defaultPadding * 0.75),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void signInAndNavigate() async {
    User? user = await signIn(usernameController.text, passwordController.text);
    print(user);
    if (user != null) {
      UserData.setCurrentUser(user);
    }
    if (user?.role == 'owner') {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OwnerHomePage()),
      );
    } 
    else if (user?.role == 'tenant') {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TenantHomePage()),
      );
    } 
    else if (user == null) {
      setState(() {
        errorMessage = 'Invalid username or password. Please try again.';
      });
    }
  }
}

class UserData {
  static User? currentUser;

  static void setCurrentUser(User? user) {
    currentUser = user;
  }
}
