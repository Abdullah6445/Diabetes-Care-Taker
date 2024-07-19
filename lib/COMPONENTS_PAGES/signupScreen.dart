import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  final nameController = TextEditingController();
  final diabetesTypeController = TextEditingController();
  String? selectedDiabetesType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/Signup_Icon.png'),
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
                    }
                    return null;
                  },
                  controllerr: passwordController,
                  labelTextt: "Enter Your Password",
                  hintTextt: "Enter Your Password Here",
                  prefixIconn: Icon(Icons.password),
                  keyboardType: TextInputType.visiblePassword,
                  obscurityy: true,
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
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
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
                                .add({
                              'name': nameController.text,
                              'diabetesType': diabetesTypeController.text,
                            });
                          }

                          Fluttertoast.showToast(msg: 'Signup successful');
                          Navigator.pushReplacementNamed(context, '/login');
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: 'Please Enter Correct Details');
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
      ),
    );
  }
}
