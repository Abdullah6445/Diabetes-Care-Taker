import 'package:diabetes_care_taker/COMPONENTS_PAGES/forgetPasswordScreen.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:form_field_validator/form_field_validator.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              // CircleAvatar(
              //   radius: 70,
              //   backgroundColor: Colors.white,
              //   backgroundImage: AssetImage('assets/images/Login_Icon_2.png'),
              // ),
              Image.asset(
                'assets/images/Login_Icon_2.png',
                scale: 4,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Wellcome Back to Diabetes Caretaker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
              ),
              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Please Enter Your Email"),
                ]),
                controllerr: emailController,
                labelTextt: "Enter Your Email",
                hintTextt: "Enter Your Email",
                prefixIconn: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),

              // TextFormField(
              //   controller: emailController,
              //   decoration: InputDecoration(labelText: 'Email'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your email';
              //     }
              //     return null;
              //   },
              // ),

              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Please Enter Your Password"),
                ]),
                controllerr: passwordController,
                labelTextt: "Enter Your Password",
                hintTextt: "Enter Your Password",
                prefixIconn: Icon(Icons.password),
                keyboardType: TextInputType.visiblePassword,
                obscurityy: _isPasswordHidden,
                suffixIconn: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
              ),

              // TextFormField(
              //   controller: passwordController,
              //   decoration: InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your password';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        String uid = userCredential.user?.uid ?? '';
                        if (uid.isNotEmpty) {
                          CustomToast(message: 'Login successful');
                          print('Navigating to home screen');
                          Navigator.pushReplacementNamed(context, '/home');
                          print('Navigation executed');
                        } else {
                          CustomToast(message: 'Please register your account');
                        }
                        // Fluttertoast.showToast(msg: 'Login successful');
                        // print('Navigating to home screen');
                        // Navigator.pushReplacementNamed(context, '/home');
                        // print('Navigation executed');
                      } catch (e) {
                        CustomToast(
                            message: 'Please Enter Correct Email and Password');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text('Don\'t have an account? Signup'),
              ),
              SizedBox(
                height: 150,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => forgetPasswordScreen(),
                    ),
                  );
                },
                child: Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
