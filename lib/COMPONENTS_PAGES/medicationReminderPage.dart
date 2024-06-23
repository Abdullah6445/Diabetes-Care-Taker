// import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationDetailsModel {
//   final int id; // Add id to uniquely identify notifications
//   final String title;
//   final String description;
//   final DateTime dateTime;
//   final bool isDaily;

//   NotificationDetailsModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dateTime,
//     required this.isDaily,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'dateTime': dateTime.toIso8601String(),
//       'isDaily': isDaily,
//     };
//   }

//   factory NotificationDetailsModel.fromMap(Map<String, dynamic> map) {
//     return NotificationDetailsModel(
//       id: map['id'],
//       title: map['title'],
//       description: map['description'],
//       dateTime: DateTime.parse(map['dateTime']),
//       isDaily: map['isDaily'],
//     );
//   }
// }

// class medicationReminderPage extends StatefulWidget {
//   const medicationReminderPage({Key? key}) : super(key: key);

//   @override
//   State<medicationReminderPage> createState() => _medicationReminderPageState();
// }

// class _medicationReminderPageState extends State<medicationReminderPage> {
//   GlobalKey<FormState> form_key = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     setting_state();
//     initialization();
//     _loadNotifications();
//     setting_state();
//   }

//   void setting_state() {
//     setState(() {});
//   }

//   void showFormDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Schedule Notification'),
//               content: SingleChildScrollView(
//                 child: Form(
//                   key: form_key,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.always,
//                         validator: (value) {
//                           if (value!.trimLeft().isEmpty) {
//                             return "Title is required";
//                           }
//                           return null;
//                         },
//                         controller: _title,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           label: Text('Notification Title'),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.always,
//                         validator: (value) {
//                           if (value!.trimLeft().isEmpty) {
//                             return "Description is required";
//                           }
//                           return null;
//                         },
//                         controller: _desc,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           label: Text('Notification Description'),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.always,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Date is required";
//                           }
//                           return null;
//                         },
//                         controller: _date,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           suffixIcon: InkWell(
//                             child: Icon(Icons.date_range),
//                             onTap: () async {
//                               final DateTime? newlySelectedDate =
//                                   await showDatePicker(
//                                 context: context,
//                                 initialDate: dateTime,
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2095),
//                               );
//                               if (newlySelectedDate != null) {
//                                 setState(() {
//                                   dateTime = newlySelectedDate;
//                                   _date.text =
//                                       '${dateTime.year}/${dateTime.month}/${dateTime.day}';
//                                 });
//                               }
//                             },
//                           ),
//                           label: Text('Date'),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.always,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Time is required";
//                           }
//                           return null;
//                         },
//                         controller: _time,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           suffixIcon: InkWell(
//                             child: const Icon(Icons.timer_outlined),
//                             onTap: () async {
//                               final TimeOfDay? selectedTime =
//                                   await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay.now(),
//                               );
//                               if (selectedTime != null) {
//                                 _time.text =
//                                     '${selectedTime.hour}:${selectedTime.minute}';
//                                 DateTime newDT = DateTime(
//                                   dateTime.year,
//                                   dateTime.month,
//                                   dateTime.day,
//                                   selectedTime.hour,
//                                   selectedTime.minute,
//                                 );
//                                 setState(() {
//                                   dateTime = newDT;
//                                 });
//                               }
//                             },
//                           ),
//                           label: Text('Time'),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       CheckboxListTile(
//                         title: Text("Repeat Daily"),
//                         value: isDaily,
//                         onChanged: (value) {
//                           setState(() {
//                             isDaily = value ?? false;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 24.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               clear();
//                             },
//                             child: Text("Close"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (form_key.currentState!.validate()) {
//                                 showScheduleNotification();
//                                 clear();

//                                 Navigator.pop(context);
//                                 // handleRefresh();
//                               } else {
//                                 CustomToast(
//                                     message:
//                                         "Not added, All Fields are required");
//                               }
//                             },
//                             child: Text('Show Notification'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     ).then((value) => setState(() {}));
//   }

//   void showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete All Notifications"),
//           content: Text("Are you sure you want to delete all notifications?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               child: Text("Delete"),
//               onPressed: () {
//                 _deleteAllNotifications();

//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> handleRefresh() async {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: handleRefresh,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.separated(
//                 itemCount: _notifications.length,
//                 itemBuilder: (context, index) {
//                   final notification = _notifications[index];
//                   return ListTile(
//                     title: Text(
//                       notification.title,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       notification.description,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '${notification.dateTime.hour}:${notification.dateTime.minute}  ${notification.dateTime.day}/${notification.dateTime.month}/${notification.dateTime.year}',
//                           style: TextStyle(fontSize: 15, color: Colors.green),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete_forever, color: Colors.red),
//                           onPressed: () {
//                             deleteNotification(index);
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return Divider(
//                     color: Color.fromARGB(255, 5, 65, 114),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             backgroundColor: Colors.red,
//             onPressed: () {
//               showDeleteConfirmationDialog(context);
//               setState(() {});
//             },
//             child: Icon(Icons.delete),
//           ),
//           SizedBox(width: 10),
//           FloatingActionButton(
//             backgroundColor: Color.fromARGB(255, 5, 65, 114),
//             onPressed: () {
//               debugPrint("talha");
//               setState(() {
//                 showFormDialog(context);
//               });
//               debugPrint("talha2");
//             },
//             child: Icon(Icons.notifications),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //////////////
// //////////////
// ///////////////

// final TextEditingController _title =
//     TextEditingController(text: "Diabetes CareTaker");
// final TextEditingController _desc = TextEditingController(
//     text: "It's time to take your insulin, Make sure to take your insulin");
// final TextEditingController _date = TextEditingController();
// final TextEditingController _time = TextEditingController();
// bool isDaily = false;
// DateTime dateTime = DateTime.now();
// int notificationId = 0;
// final List<NotificationDetailsModel> _notifications = [];

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void initialization() {
//   const AndroidInitializationSettings androidInitializationSettings =
//       AndroidInitializationSettings('noti');
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: androidInitializationSettings,
//     iOS: null,
//   );
//   flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
// }

// Future<void> _saveNotifications() async {
//   final prefs = await SharedPreferences.getInstance();
//   List<String> notificationStrings = _notifications.map((notification) {
//     return jsonEncode(notification.toMap());
//   }).toList();
//   prefs.setStringList('notifications', notificationStrings);
// }

// Future<void> _loadNotifications() async {
//   final prefs = await SharedPreferences.getInstance();
//   List<String>? notificationStrings = prefs.getStringList('notifications');
//   if (notificationStrings != null) {
//     _notifications.clear();
//     _notifications.addAll(notificationStrings.map((notificationString) {
//       return NotificationDetailsModel.fromMap(jsonDecode(notificationString));
//     }).toList());
//   }
// }

// Future<void> showScheduleNotification() async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//     'ScheduleNotification001',
//     'Notify Me',
//     importance: Importance.high,
//   );

//   const NotificationDetails notificationDetails = NotificationDetails(
//     android: androidNotificationDetails,
//     iOS: null,
//   );

//   tz.initializeTimeZones();
//   final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

//   if (isDaily) {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       notificationId,
//       _title.text,
//       _desc.text,
//       scheduledAt,
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.wallClockTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       payload: 'This is the data',
//     );
//   } else {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       notificationId,
//       _title.text,
//       _desc.text,
//       scheduledAt,
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.wallClockTime,
//       payload: 'This is the data',
//     );
//   }

//   _addNotificationDetails();
// }

// void _addNotificationDetails() {
//   int id = notificationId++;
//   _notifications.add(
//     NotificationDetailsModel(
//       id: id,
//       title: _title.text,
//       description: _desc.text,
//       dateTime: dateTime,
//       isDaily: isDaily,
//     ),
//   );
//   _saveNotifications();
// }

// void deleteNotification(int index) async {
//   if (index >= 0 && index < _notifications.length) {
//     await flutterLocalNotificationsPlugin.cancel(_notifications[index].id);
//     _notifications.removeAt(index);
//     _saveNotifications();
//   }
// }

// void _deleteAllNotifications() async {
//   for (var notification in _notifications) {
//     await flutterLocalNotificationsPlugin.cancel(notification.id);
//   }
//   _notifications.clear();
//   _saveNotifications();
// }

// void clear() {
//   _date.text = "";
//   _time.text = "";
//   isDaily = false;
// }

import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationDetailsModel {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isDaily;

  NotificationDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isDaily,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isDaily': isDaily,
    };
  }

  factory NotificationDetailsModel.fromMap(Map<String, dynamic> map) {
    return NotificationDetailsModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      isDaily: map['isDaily'],
    );
  }
}

class medicationReminderPage extends StatefulWidget {
  const medicationReminderPage({Key? key}) : super(key: key);

  @override
  State<medicationReminderPage> createState() => _medicationReminderPageState();
}

class _medicationReminderPageState extends State<medicationReminderPage> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    initialization();
    _loadNotifications();
  }

  void initialization() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('noti');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings, iOS: null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
    setState(() {});
  }

  Future<void> showFormDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text('Schedule Notification'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
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
                        controller: _descController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0)),
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
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
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
                                  _dateController.text =
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
                        controller: _timeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          suffixIcon: InkWell(
                            child: const Icon(Icons.timer_outlined),
                            onTap: () async {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                _timeController.text =
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
                              if (formKey.currentState!.validate()) {
                                showScheduleNotification();
                                clear();
                                Navigator.pop(context);
                              } else {
                                CustomToast(message: "All fields are required");
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

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete All Notifications"),
          content: Text("Are you sure you want to delete all notifications?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Delete"),
              onPressed: () {
                _deleteAllNotifications();
                Navigator.of(context).pop();
              },
            ),
          ],
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
        key: refreshIndicatorKey,
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
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${notification.dateTime.hour}:${notification.dateTime.minute}  ${notification.dateTime.day}/${notification.dateTime.month}/${notification.dateTime.year}',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_forever, color: Colors.red),
                          onPressed: () async {
                            await deleteNotification(index);
                            refreshIndicatorKey.currentState?.show();
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
            backgroundColor: Colors.red,
            onPressed: () async {
              await showDeleteConfirmationDialog(context);
              refreshIndicatorKey.currentState?.show();
            },
            child: Icon(Icons.delete),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 5, 65, 114),
            onPressed: () async {
              await showFormDialog(context);
              refreshIndicatorKey.currentState?.show();
            },
            child: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }

  void clear() {
    _dateController.text = "";
    _timeController.text = "";
    isDaily = false;
  }
}

///////////////////////////
///
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
final TextEditingController _titleController =
    TextEditingController(text: "Diabetes CareTaker");
final TextEditingController _descController = TextEditingController(
    text: "It's time to take your insulin, Make sure to take your insulin");
final TextEditingController _dateController = TextEditingController();
final TextEditingController _timeController = TextEditingController();
bool isDaily = false;
DateTime dateTime = DateTime.now();
int notificationId = 0;
final List<NotificationDetailsModel> _notifications = [];
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showScheduleNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'ScheduleNotification001',
    'Notify Me',
    importance: Importance.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails, iOS: null);

  final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

  if (isDaily) {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      _titleController.text,
      _descController.text,
      scheduledAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'This is the data',
    );
  } else {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      _titleController.text,
      _descController.text,
      scheduledAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      payload: 'This is the data',
    );
  }

  _addNotificationDetails();
}

void _addNotificationDetails() async {
  int id = notificationId++;
  _notifications.add(
    NotificationDetailsModel(
      id: id,
      title: _titleController.text,
      description: _descController.text,
      dateTime: dateTime,
      isDaily: isDaily,
    ),
  );
  await _saveNotifications();
}

Future<void> _saveNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> notificationStrings = _notifications.map((notification) {
    return jsonEncode(notification.toMap());
  }).toList();
  prefs.setStringList('notifications', notificationStrings);
}

Future<void> deleteNotification(int index) async {
  if (index >= 0 && index < _notifications.length) {
    await flutterLocalNotificationsPlugin.cancel(_notifications[index].id);
    _notifications.removeAt(index);
    await _saveNotifications();
  }
}

void _deleteAllNotifications() async {
  for (var notification in _notifications) {
    await flutterLocalNotificationsPlugin.cancel(notification.id);
  }
  _notifications.clear();
  await _saveNotifications();
}
