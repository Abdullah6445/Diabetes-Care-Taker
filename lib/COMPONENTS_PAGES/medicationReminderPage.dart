import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationDetailsModel {
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isDaily;

  NotificationDetailsModel(
      this.title, this.description, this.dateTime, this.isDaily);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isDaily': isDaily,
    };
  }

  factory NotificationDetailsModel.fromMap(Map<String, dynamic> map) {
    return NotificationDetailsModel(
      map['title'],
      map['description'],
      DateTime.parse(map['dateTime']),
      map['isDaily'],
    );
  }
}

class medicationReminderPage extends StatefulWidget {
  const medicationReminderPage({Key? key}) : super(key: key);

  @override
  State<medicationReminderPage> createState() => _medicationReminderPageState();
}

class _medicationReminderPageState extends State<medicationReminderPage> {
  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initialization();
    _loadNotifications();
    setting_state();
  }

  void setting_state() {
    setState(() {});
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
                        autovalidateMode: AutovalidateMode.always,
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
                        autovalidateMode: AutovalidateMode.always,
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
                        autovalidateMode: AutovalidateMode.always,
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
                        autovalidateMode: AutovalidateMode.always,
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
                              if (form_key.currentState!.validate()) {
                                showScheduleNotification();
                                setting_state();
                                clear();

                                Navigator.pop(context);
                              } else {
                                CustomToast(
                                    message:
                                        "Not added, All Fields are required");
                              }
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
                    title: Text(
                      notification.title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      notification.description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${notification.dateTime.hour}:${notification.dateTime.minute}  ${notification.dateTime.day}/${notification.dateTime.month}/${notification.dateTime.year}',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                        IconButton(
                          icon: Icon(Icons.notification_add, color: Colors.red),
                          onPressed: () {
                            // _deleteNotification(index);
                            // deleteSelectedSchedule(index);
                            setting_state();
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Color.fromARGB(255, 5, 65, 114),
                  );
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

//////////////
//////////////
///////////////

final TextEditingController _title =
    TextEditingController(text: "Diabetes CareTaker");
final TextEditingController _desc = TextEditingController(
    text: "It's time to take your insulin, Make sure to take your insulin");
final TextEditingController _date = TextEditingController();
final TextEditingController _time = TextEditingController();
bool isDaily = false;
DateTime dateTime = DateTime.now();
int notificationId = 0;
final List<NotificationDetailsModel> _notifications = [];

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

Future<void> _saveNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> notificationStrings = _notifications.map((notification) {
    return jsonEncode(notification.toMap());
  }).toList();
  prefs.setStringList('notifications', notificationStrings);
}

Future<void> _loadNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? notificationStrings = prefs.getStringList('notifications');
  if (notificationStrings != null) {
    _notifications.clear();
    _notifications.addAll(notificationStrings.map((notificationString) {
      return NotificationDetailsModel.fromMap(jsonDecode(notificationString));
    }).toList());
  }
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
  _saveNotifications();
}

void clear() {
  _date.text = "";
  _time.text = "";
  isDaily = false;
}

// void deleteSelectedSchedule(int index) async {
//   if (index < 0 || index >= _notifications.length) {
//     return;
//   }

//   await flutterLocalNotificationsPlugin.cancel(index);

//   _notifications.removeAt(index);

//   _saveNotifications();
// }
