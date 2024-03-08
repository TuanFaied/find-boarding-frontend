import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../../auth/authentication.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String selectedRole = 'tenant';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          Padding(
            
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.5,
              horizontal: defaultPadding ,
            ),
            
            child: TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.5, horizontal: defaultPadding ,),
            child: TextFormField(
              controller: usernameController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your Username",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person_2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.5,horizontal: defaultPadding ,),
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
          const SizedBox(height: defaultPadding / 2),
          
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.5,horizontal: defaultPadding*1.5 , ),
                child: Text(
                  'User Role:',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: selectedRole,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedRole = newValue;
                    });
                  }
                },
                items: <String>['tenant', 'owner']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                
                dropdownColor:const Color.fromARGB(255, 236, 231, 143),
                elevation: 8, // Dropdown elevation
                borderRadius: BorderRadius.circular(10),
                underline: Container(),
                

              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              
              if (_formKey.currentState?.validate() ?? false){
                if (selectedRole == 'tenant') {
                signUpTenant(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  selectedRole,
                );
              } else if (selectedRole == 'owner') {
                signUpOwner(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  selectedRole,
                );
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              },
              ),
              );

              }
              
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
