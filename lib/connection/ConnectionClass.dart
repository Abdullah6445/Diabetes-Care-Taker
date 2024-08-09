import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionClass {
  int internetChanged = 0;

  void connection_function() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      debugPrint(status.toString());
      switch (status) {
        case InternetConnectionStatus.disconnected:
          internetChanged++;

          debugPrint("disconnecteddddddddd");

          Get.snackbar("No Internet Connection", "Please check your internet.",
              icon: Icon(
                Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                color: Colors.red.shade900,
              ),
              backgroundColor: Colors.blue.shade200,
              colorText: Colors.red.shade900,
              duration: null,
              mainButton: TextButton(
                  onPressed: () {
                    Get.closeCurrentSnackbar();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )));
          break;
        case InternetConnectionStatus.connected:
          if (internetChanged == 1) {
            Get.snackbar(
              "Internet is back",
              "Great, your internet connection is restored.",
              icon: Icon(
                Icons.signal_wifi_4_bar_lock_rounded,
                color: Colors.green.shade900,
              ),
              backgroundColor: Colors.blue.shade200,
              colorText: Colors.green.shade900,
            );
            internetChanged = 0;
          }
          break;
      }
    });
  }

  Future<void> connection_function_navigator(Widget widget) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Get.to(widget);
    } else {
      Get.snackbar(
        "No Internet Connection",
        "Please check your internet.",
        icon: Icon(
          Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
          color: Colors.red.shade900,
        ),
        backgroundColor: Colors.blue.shade200,
        colorText: Colors.red.shade900,
      );
    }
  }
}
