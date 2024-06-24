import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class emergencyAlertPage extends StatefulWidget {
  const emergencyAlertPage({Key? key}) : super(key: key);

  @override
  State<emergencyAlertPage> createState() => _emergencyAlertPageState();
}

class _emergencyAlertPageState extends State<emergencyAlertPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Map<String, String>> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contacts = (prefs.getStringList('contacts') ?? []).map((contact) {
        List<String> parts = contact.split(':');
        return {'name': parts[0], 'phone': parts[1]};
      }).toList();
    });
  }

  void saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serializedContacts = contacts
        .map((contact) => '${contact['name']}:${contact['phone']}')
        .toList();
    prefs.setStringList('contacts', serializedContacts);
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
      saveContacts();
    });
  }

  void deleteAllContacts() {
    setState(() {
      contacts.clear();
      saveContacts();
    });
  }

  void sendWhatsAppMessage(String phone_number) {
    final String message =
        "DIABETES CARETAKER APP\n\nDear Guardians,\nYour Patient is in need of medical help.\nWe regret to inform you that your patient requires immediate medical attention due to their diabetes condition.\nPlease Contact them and take the necessary steps to ensure they receive prompt care.";
    String url = "whatsapp://send?phone=$phone_number&text=$message";
    launchUrl(Uri.parse(url));
  }

  void showEditFormDialog(int index) {
    final contact = contacts[index];
    _nameController.text = contact['name']!;
    _phoneController.text = contact['phone']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Emergency Contact'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: "Name",
                      hintText: "Enter name here...",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Number is required";
                      }
                      return null;
                    },
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: "PhoneNumber",
                      hintText: "+92XXXXXXXXXX",
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              contacts[index] = {
                                'name': _nameController.text,
                                'phone': _phoneController.text,
                              };
                              saveContacts();
                            });
                            Navigator.pop(context);
                          } else {
                            CustomToast(message: "All fields are required");
                          }
                        },
                        child: Text('Update Contact'),
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
  }

  void showDeleteContactDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete All Contacts"),
          content: Text("Are you sure you want to delete all contacts?"),
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
                deleteAllContacts();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showFormDialog() {
    _nameController.clear();
    _phoneController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Emergency Contact'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: "Name",
                      hintText: "Enter name here...",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Number is required";
                      }
                      return null;
                    },
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: "PhoneNumber",
                      hintText: "+92XXXXXXXXXX",
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              contacts.add({
                                'name': _nameController.text,
                                'phone': _phoneController.text,
                              });
                              saveContacts(); // Save after adding
                            });
                            Navigator.pop(context);
                          } else {
                            CustomToast(message: "All fields are required");
                          }
                        },
                        child: Text('Add Contact'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: showDeleteContactDialog,
          ),
          // Replace `popupMenuPage()` with your actual implementation
          // popupMenuPage(),
        ],
        elevation: 10,
        title: Text("Emergency Alert"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                      child: Image.asset("assets/images/person.png")),
                  title: Text(
                    contact['name']!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    contact['phone']!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteContact(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showEditFormDialog(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.message,
                          color: Colors.green,
                        ),
                        onPressed: () async {
                          if (await InternetConnectionChecker().hasConnection) {
                            debugPrint('Phone number: ${contact['phone']}');
                            sendWhatsAppMessage("${contact['phone']}");
                          } else {
                            Get.snackbar(
                              "No Internet Connection",
                              "Please check your internet.",
                              icon: Icon(
                                Icons
                                    .signal_wifi_statusbar_connected_no_internet_4_rounded,
                                color: Colors.red.shade900,
                              ),
                              backgroundColor: Colors.blue.shade200,
                              colorText: Colors.red.shade900,
                            );
                          }
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 5, 65, 114),
        onPressed: () {
          showFormDialog();
        },
        child: Icon(Icons.add_call),
      ),
    );
  }
}















// import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
// import 'package:diabetes_care_taker/PAGES/popupMenuPage.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class emergencyAlertPage extends StatefulWidget {
//   const emergencyAlertPage({super.key});

//   @override
//   State<emergencyAlertPage> createState() => _emergencyAlertPageState();
// }

// class _emergencyAlertPageState extends State<emergencyAlertPage> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();

//   List<Map<String, String>> contacts = [];

//   void deleteContact(int index) {
//     setState(() {
//       contacts.removeAt(index);
//     });
//   }

//   void deleteAllContacts() {
//     setState(() {
//       contacts.clear();
//     });
//   }

//   void sendWhatsAppMessage(String phone_number) {
//     final String message = 'Hello, this is a test message';

//     String url = "whatsapp://send?phone=$phone_number&text=$message";
//     launchUrl(Uri.parse(url));
//   }

//   void showEditFormDialog(int index) {
//     final contact = contacts[index];
//     _nameController.text = contact['name']!;
//     _phoneController.text = contact['phone']!;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit Emergency Contact'),
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     keyboardType: TextInputType.text,
//                     autovalidateMode: AutovalidateMode.always,
//                     validator: (value) {
//                       if (value!.trimLeft().isEmpty) {
//                         return "Name is required";
//                       }
//                       return null;
//                     },
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0)),
//                       labelText: "Name",
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     autovalidateMode: AutovalidateMode.always,
//                     validator: (value) {
//                       if (value!.trimLeft().isEmpty) {
//                         return "Number is required";
//                       }
//                       return null;
//                     },
//                     controller: _phoneController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0)),
//                       labelText: "PhoneNumber",
//                       hintText: "+123456789",
//                     ),
//                   ),
//                   const SizedBox(height: 24.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text("Close"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             setState(() {
//                               contacts[index] = {
//                                 'name': _nameController.text,
//                                 'phone': _phoneController.text,
//                               };
//                             });
//                             Navigator.pop(context);
//                           } else {
//                             CustomToast(message: "All fields are required");
//                           }
//                         },
//                         child: Text('Update Contact'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void showDeleteContactDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete All Contacts"),
//           content: Text("Are you sure you want to delete all contacts?"),
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
//                 deleteAllContacts();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void showFormDialog() {
//     _nameController.clear();
//     _phoneController.clear();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Emergency Contact'),
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     keyboardType: TextInputType.text,
//                     autovalidateMode: AutovalidateMode.always,
//                     validator: (value) {
//                       if (value!.trimLeft().isEmpty) {
//                         return "Name is required";
//                       }
//                       return null;
//                     },
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0)),
//                       labelText: "Name",
//                       hintText: "Enter name here...",
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     autovalidateMode: AutovalidateMode.always,
//                     validator: (value) {
//                       if (value!.trimLeft().isEmpty) {
//                         return "Number is required";
//                       }
//                       return null;
//                     },
//                     controller: _phoneController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16.0)),
//                       labelText: "PhoneNumber",
//                       hintText: "+923317012500",
//                     ),
//                   ),
//                   const SizedBox(height: 24.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text("Close"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             setState(() {
//                               contacts.add({
//                                 'name': _nameController.text,
//                                 'phone': _phoneController.text,
//                               });
//                             });

//                             Navigator.pop(context);
//                           } else {
//                             CustomToast(message: "All fields are required");
//                           }
//                         },
//                         child: Text('Add Contact'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.delete,
//               color: Colors.red,
//             ),
//             onPressed: showDeleteContactDialog,
//           ),
//           popupMenuPage(),
//         ],
//         elevation: 10,
//         title: Text("Emergency Alert"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.separated(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 return ListTile(
//                   title: Text(
//                     contact['name']!,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     contact['phone']!,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ),
//                         onPressed: () {
//                           deleteContact(index);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.black,
//                         ),
//                         onPressed: () {
//                           showEditFormDialog(index);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.message,
//                           color: Colors.green,
//                         ),
//                         onPressed: () {
//                           debugPrint('Phone number: ${contact['phone']}');
//                           sendWhatsAppMessage("${contact['phone']}");
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return Divider(
//                   color: Color.fromARGB(255, 5, 65, 114),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromARGB(255, 5, 65, 114),
//         onPressed: () {
//           showFormDialog();
//         },
//         child: Icon(Icons.add_call),
//       ),
//     );
//   }
// }
