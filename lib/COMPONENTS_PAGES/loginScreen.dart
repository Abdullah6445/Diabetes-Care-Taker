import 'package:diabetes_care_taker/COMPONENTS_PAGES/forgetPasswordScreen.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';

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
              const SizedBox(height: 100),
              Image.asset(
                'assets/images/Login_Icon_2.png',
                scale: 4,
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Wellcome Back to Diabetes Caretaker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              customTextFormField(
                validatorrr: (p0) {
                  if (p0!.trimLeft().isEmpty) {
                    return "Please Enter Your Email";
                  }
                  return null;
                },
                controllerr: emailController,
                labelTextt: "Enter Your Email",
                hintTextt: "Enter Your Email",
                prefixIconn: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              customTextFormField(
                validatorrr: (p0) {
                  if (p0!.trimLeft().isEmpty) {
                    return "Please Enter Your Password";
                  }
                  return null;
                },
                controllerr: passwordController,
                labelTextt: "Enter Your Password",
                hintTextt: "Enter Your Password",
                prefixIconn: const Icon(Icons.password),
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
              const SizedBox(
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
                  child: const Row(
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
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Don\'t have an account? Signup'),
              ),
              const SizedBox(
                height: 20,
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
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
