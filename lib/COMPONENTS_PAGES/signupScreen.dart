import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

class signupScreen extends StatefulWidget {
  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final diabetesTypeController = TextEditingController();
  String? selectedDiabetesType;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   radius: 70,
              //   backgroundColor: Colors.white70,
              //   backgroundImage: AssetImage('assets/images/Signup_Icon.png'),
              // ),
              SizedBox(height: 90),
              Image.asset(
                'assets/images/Signup_Icon.png',
                scale: 4,
              ),
              SizedBox(
                height: 35,
              ),
              // TextFormField(
              //   controller: nameController,
              //   decoration: InputDecoration(labelText: 'Name'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     return null;
              //   },
              // ),
              customTextFormField(
                validatorrr: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                controllerr: nameController,
                labelTextt: "Enter Your Name",
                hintTextt: "Enter Your Name Here",
                prefixIconn: Icon(Icons.person),
                keyboardType: TextInputType.text,
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
                validatorrr: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controllerr: emailController,
                labelTextt: "Enter Your Email",
                hintTextt: "Enter Your Email Here",
                prefixIconn: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
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
              customTextFormField(
                validatorrr: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length <= 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                controllerr: passwordController,
                labelTextt: "Enter Your Password",
                hintTextt: "Enter Your Password Here",
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
              customTextFormField(
                validatorrr: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password again';
                  } else if (value != passwordController.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
                controllerr: confirmPasswordController,
                labelTextt: "Confirm Password",
                hintTextt: "Confirm Password",
                prefixIconn: Icon(Icons.password),
                keyboardType: TextInputType.visiblePassword,
                obscurityy: _isConfirmPasswordHidden,
                suffixIconn: IconButton(
                  icon: Icon(
                    _isConfirmPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                ),
              ),

              // TextFormField(
              //   controller: diabetesTypeController,
              //   decoration: InputDecoration(labelText: 'Type of Diabetes'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your type of diabetes';
              //     }
              //     return null;
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
                child: DropdownButtonFormField<String>(
                  value: selectedDiabetesType,
                  decoration: InputDecoration(
                    labelText: 'Type of Diabetes',
                    prefixIcon: Icon(Icons.bloodtype),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    isDense: true,
                  ),
                  items: <String>['Type 1', 'Type 2'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDiabetesType = newValue;
                      diabetesTypeController.text = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your type of diabetes';
                    }
                    return null;
                  },
                ),
              ),
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
                            await _auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        String uid = userCredential.user?.uid ?? '';

                        if (uid.isNotEmpty) {
                          await _firestore
                              .collection('users')
                              .doc(uid)
                              .collection('about_user')
                              .doc(uid)
                              .set({
                            'name': nameController.text,
                            'diabetesType': diabetesTypeController.text,
                            'email': emailController.text,
                          });
                        }

                        CustomToast(message: 'Signup successful');
                        Navigator.pushReplacementNamed(context, '/login');
                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          if (e.code == 'email-already-in-use') {
                            CustomToast(
                                message:
                                    'You have already created your account, Please log in');
                          } else if (e.code == 'invalid-email') {
                            CustomToast(
                                message: 'The email address is not valid');
                          } else {
                            CustomToast(
                                message:
                                    'Error occurred. Please try sign up again');
                          }
                        } else {
                          CustomToast(
                              message:
                                  'Error occurred. Please try sign up again');
                        }
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
                        'Signup ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 75,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Already have an account?  Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
