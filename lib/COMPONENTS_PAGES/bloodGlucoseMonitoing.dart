import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/displayBloodGlucoseLevels.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class bloodGlucoseMonitoring extends StatefulWidget {
  const bloodGlucoseMonitoring({super.key});

  @override
  State<bloodGlucoseMonitoring> createState() => _bloodGlucoseMonitoringState();
}

class _bloodGlucoseMonitoringState extends State<bloodGlucoseMonitoring> {
  final _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final bglevelController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final carbsController = TextEditingController();
  final bolusInsulinController = TextEditingController();
  final basalInsulinController = TextEditingController();
  final noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    print('bloodGlucoseMonitoring initState');
  }

  @override
  Widget build(BuildContext context) {
    print('Building bloodGlucoseMonitoring page');
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Blood Glucose Monitoring',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              customTextFormField(
                controllerr: bglevelController,
                labelTextt: "Enter your Blood Sugar Level",
                hintTextt: "Enter your Blood Sugar Level",
                prefixIconn: Icon(Icons.bloodtype),
                keyboardType: TextInputType.number,
                validatorrr: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Blood Glucose Reading';
                  } else if (value.length < 2) {
                    return 'Your Blood Glucose Reading must be in two digits';
                  } else if (value.length > 3) {
                    return 'Please Check Your Blood Glucose Reading Again';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: customTextFormField(
                      controllerr: dateController,
                      labelTextt: "Select Date",
                      hintTextt: "Select Date",
                      prefixIconn: Icon(Icons.calendar_today),
                      readOnlyy: true,
                      onTap: _selectDate,
                      validatorrr: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: customTextFormField(
                      controllerr: timeController,
                      labelTextt: "Select Time",
                      hintTextt: "Select Time",
                      prefixIconn: Icon(Icons.access_time),
                      readOnlyy: true,
                      onTap: _selectTime,
                      validatorrr: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              customTextFormField(
                controllerr: carbsController,
                labelTextt: "Enter Carbs Intake",
                hintTextt: "Enter Carbs Intake",
                prefixIconn: Icon(Icons.food_bank),
                keyboardType: TextInputType.number,
              ),
              customTextFormField(
                controllerr: bolusInsulinController,
                labelTextt: "Enter Bolus Insulin Units Injected",
                hintTextt: "Enter Bolus Insulin Units Injected",
                prefixIconn: Icon(FontAwesomeIcons.syringe),
                keyboardType: TextInputType.number,
              ),
              customTextFormField(
                controllerr: basalInsulinController,
                labelTextt: "Enter Basal Insulin Units Injected",
                hintTextt: "Enter Basal Insulin Units Injected",
                prefixIconn: Icon(FontAwesomeIcons.syringe),
                keyboardType: TextInputType.number,
              ),
              customTextFormField(
                controllerr: noteController,
                labelTextt: "Enter Your Note Here",
                hintTextt: "Enter Your Note Here",
                keyboardType: TextInputType.text,
                prefixIconn: Icon(FontAwesomeIcons.noteSticky),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });

                      User? user = _auth.currentUser;
                      String userId = user?.uid ?? '';

                      fireStore.doc(userId).collection('entries').add({
                        'Blood Glucose Level': bglevelController.text,
                        'Date': dateController.text,
                        'Time': timeController.text,
                        'Carb Intake': carbsController.text,
                        'Bolus Insulin Intake': bolusInsulinController.text,
                        'Basal Insulin Intake': basalInsulinController.text,
                        'Notes': noteController.text,
                      }).then((value) {
                        CustomToast(message: 'BG Level Added');
                        bglevelController.clear();
                        dateController.clear();
                        timeController.clear();
                        carbsController.clear();
                        bolusInsulinController.clear();
                        basalInsulinController.clear();
                        noteController.clear();
                        setState(() {
                          loading = false;
                        });
                      }).catchError((error) {
                        CustomToast(message: 'Error Occured, please add again');
                        setState(() {
                          loading = false;
                        });
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Add BG Readings',
                          style: TextStyle(fontSize: 17),
                        ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => displayBloodGlucoseLevels(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Display BG Readings',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }
}
