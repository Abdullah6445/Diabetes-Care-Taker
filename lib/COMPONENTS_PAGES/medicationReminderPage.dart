import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationDetailsModel {
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isDaily;

  NotificationDetailsModel(
      this.title, this.description, this.dateTime, this.isDaily);
}

class medicationReminderPage extends StatefulWidget {
  const medicationReminderPage({Key? key}) : super(key: key);

  @override
  State<medicationReminderPage> createState() => _medicationReminderPageState();
}

class _medicationReminderPageState extends State<medicationReminderPage> {
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  void validation_function() {
    if (form_key.currentState!.validate()) {
      CustomToast(message: "Added, swipe down to refresh");
    } else {
      CustomToast(message: "Not added, All Fields are required");
    }
  }

  @override
  void initState() {
    super.initState();

    initialization();
  }

  void showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Schedule Notification'),
              content: SingleChildScrollView(
                child: Form(
                  key: form_key,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.trimLeft().isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                        controller: _title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          label: Text('Notification Title'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value!.trimLeft().isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                        controller: _desc,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          label: Text('Notification Description'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Date is required";
                          }
                          return null;
                        },
                        controller: _date,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: InkWell(
                            child: Icon(Icons.date_range),
                            onTap: () async {
                              final DateTime? newlySelectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2095),
                              );

                              if (newlySelectedDate != null) {
                                setState(() {
                                  dateTime = newlySelectedDate;
                                  _date.text =
                                      '${dateTime.year}/${dateTime.month}/${dateTime.day}';
                                });
                              }
                            },
                          ),
                          label: Text('Date'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Time is required";
                          }
                          return null;
                        },
                        controller: _time,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: InkWell(
                            child: const Icon(Icons.timer_outlined),
                            onTap: () async {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (selectedTime != null) {
                                _time.text =
                                    '${selectedTime.hour}:${selectedTime.minute}';
                                DateTime newDT = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                setState(() {
                                  dateTime = newDT;
                                });
                              }
                            },
                          ),
                          label: Text('Time'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      CheckboxListTile(
                        title: Text("Repeat Daily"),
                        value: isDaily,
                        onChanged: (value) {
                          setState(() {
                            isDaily = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              clear();
                            },
                            child: Text("Close"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              validation_function();
                              showScheduleNotification();
                              clear();
                              Navigator.pop(context);
                            },
                            child: Text('Show Notification'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> handleRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return ListTile(
                    title: Text(notification.title),
                    subtitle: Text(notification.description),
                    trailing: Text(
                      '${notification.dateTime.year}-${notification.dateTime.month}-${notification.dateTime.day} ${notification.dateTime.hour}:${notification.dateTime.minute}',
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 5, 65, 114),
            onPressed: () => showFormDialog(context),
            child: Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////
///
////////////////////////////////

final TextEditingController _title =
    TextEditingController(text: "Diabetes CareTaker");
final TextEditingController _desc = TextEditingController(
    text: "Its time to take your insulin, Make sure to take your insulin");
final TextEditingController _date = TextEditingController();
final TextEditingController _time = TextEditingController();
bool isDaily = false; // Checkbox state

DateTime dateTime = DateTime.now();
int notificationId = 0; // Counter for generating unique notification IDs
final List<NotificationDetailsModel> _notifications =
    []; // List to store notifications

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool? isChecked = true;

void initialization() {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('noti');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: null,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

Future<void> showPUSHNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'ScheduleNotification001',
    'Notify Me',
    importance: Importance.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: null,
  );

  await flutterLocalNotificationsPlugin.show(
    notificationId++,
    _title.text,
    _desc.text,
    notificationDetails,
  );

  _addNotificationDetails();
}

Future<void> showScheduleNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'ScheduleNotification001',
    'Notify Me',
    importance: Importance.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: null,
  );

  tz.initializeTimeZones();
  final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

  if (isDaily) {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId++,
      _title.text,
      _desc.text,
      scheduledAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'This is the data',
    );
  } else {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId++,
      _title.text,
      _desc.text,
      scheduledAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      payload: 'This is the data',
    );
  }

  _addNotificationDetails();
}

void _addNotificationDetails() {
  _notifications.add(
    NotificationDetailsModel(
      _title.text,
      _desc.text,
      dateTime,
      isDaily,
    ),
  );
}

void clear() {
  _date.text = "";
  _time.text = "";
  isDaily = false;
}
