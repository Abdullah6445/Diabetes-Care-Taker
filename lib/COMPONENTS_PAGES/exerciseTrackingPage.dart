import 'package:diabetes_care_taker/COMPONENTS_PAGES/displayExercises.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

class exerciseLogScreen extends StatefulWidget {
  @override
  _exerciseLogScreenState createState() => _exerciseLogScreenState();
}

class _exerciseLogScreenState extends State<exerciseLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String _selectedExercise = '';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  bool loading = false;

  final List<String> exercises = [
    'Aerobics',
    'Basketball',
    'Cycling',
    'Hiking',
    'Jogging',
    'Running',
    'Swimming',
    'Tennis',
    'Walking',
    'Weightlifting',
    'Yoga'
  ]..sort();

  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _bgBeforeController = TextEditingController();
  final TextEditingController _bgAfterController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('MM/dd/yyyy').format(_date);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timeController.text = _time.format(context);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(_date);
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _timeController.text = _time.format(context);
      });
    }
  }

  int _parseInput(String input) {
    if (input.isEmpty) {
      return 0;
    } else {
      try {
        return int.parse(input);
      } catch (e) {
        return 0;
      }
    }
  }

  Future<void> _submitLog() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      User? user = _auth.currentUser;
      String userId = user?.uid ?? '';

      final DateTime combinedDateTime = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );

      await fireStore
          .doc('exerciseLogs/$userId')
          .collection('exerciseEntries')
          .add({
        'Activity': _selectedExercise,
        'Duration': _parseInput(_durationController.text),
        'Date': combinedDateTime,
        'BGBefore': _parseInput(_bgBeforeController.text),
        'BGAfter': _parseInput(_bgAfterController.text),
        'Timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        CustomToast(message: 'Exercise added');
        setState(() {
          loading = false;
        });
      }).catchError((error) {
        CustomToast(message: 'Error Occurred, Please add again');
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Exercise'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Your Exercise Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Select Exercise',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(FontAwesomeIcons.personRunning,
                        color: Color.fromARGB(255, 5, 65, 114)),
                  ),
                  items: exercises.map((String exercise) {
                    return DropdownMenuItem(
                      value: exercise,
                      child: Text(exercise),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedExercise = value as String;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an exercise';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Enter exercise duration"),
                ]),
                controllerr: _durationController,
                labelTextt: "Duration (minutes)",
                hintTextt: "Enter erercise duration",
                prefixIconn: Icon(Icons.timer),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              customTextFormField(
                // validatorrr: MultiValidator([
                //   RequiredValidator(errorText: "Enter bg levels before exercise"),
                // ]),
                controllerr: _bgBeforeController,
                labelTextt: "Blood Glucose Level Before Exercise",
                hintTextt: "Enter BG level",
                prefixIconn: Icon(Icons.health_and_safety),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              customTextFormField(
                // validatorrr: MultiValidator([
                //   RequiredValidator(errorText: "Enter bg levels after exercise"),
                // ]),
                controllerr: _bgAfterController,
                labelTextt: "Blood Glucose Level After Exercise",
                hintTextt: "Enter BG level",
                prefixIconn: Icon(Icons.health_and_safety),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: customTextFormField(
                      validatorrr: MultiValidator([
                        RequiredValidator(errorText: "Enter exercise date"),
                      ]),
                      controllerr: _dateController,
                      labelTextt: "Date",
                      hintTextt: "Select exercise date",
                      prefixIconn: Icon(Icons.calendar_today),
                      readOnlyy: true,
                      onTap: _selectDate,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: customTextFormField(
                      validatorrr: MultiValidator([
                        RequiredValidator(errorText: "Enter exercise time"),
                      ]),
                      controllerr: _timeController,
                      labelTextt: "Time",
                      hintTextt: "Select exercise time",
                      prefixIconn: Icon(Icons.access_time),
                      readOnlyy: true,
                      onTap: _selectTime,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              loading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 45,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _submitLog,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text('Add Exercise',
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => displayExercises(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text('Track Your Exercises',
                      style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
