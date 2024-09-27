import 'dart:async';
import 'dart:math';
import 'package:bitau/BLE/ble_controller.dart';
import 'package:bitau/controller/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Declare the notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MenuPopup extends StatefulWidget {
  @override
  State<MenuPopup> createState() => _MenuPopupState();
}

class _MenuPopupState extends State<MenuPopup> {
  bool close = false;
  int rssiValue = 0;
  String name = "";
  String trimmedName = '';
  late Timer periodicTimer;
  bool popupDisplayed = false;
  bool showButtons = true;
  String displayedPassword = '';
  bool notificationShown = false; // Track notification status

  @override
  void initState() {
    super.initState();

    // Initialize notifications settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('assets/itau.png');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permissions for notifications on Android 13+
    _requestNotificationPermission();

    Get.put(BleController());

    // Start the periodic timer for scanning devices
    periodicTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (!popupDisplayed) {
        Get.find<BleController>().scanDevices();
      }
    });

    Get.find<BleController>().scanResults.listen((List<ScanResult> scanResults) {
      _checkBluetoothResults(scanResults);
    });
  }

  // Function to request notification permissions using permission_handler
  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status != PermissionStatus.granted) {
      // Show a message indicating that notifications won't work without permission
      print('Notificações não serão exibidas sem permissão!');
    }
  }

  void _checkBluetoothResults(List<ScanResult> scanResults) {
    for (var result in scanResults) {
      if (result.advertisementData.serviceUuids!
          .contains('4fafc201-1fb5-459e-8fcc-c5c9c331914b')) {
        rssiValue = result.rssi;
        name = result.device.name;
        int endIndex = name.indexOf('') + 0; // Ensure this logic is correct
        trimmedName = name.substring(endIndex);

        // Show notification when beacon is found and not already shown
        if (!notificationShown) {
          _showNotification('Hey!',
              'Vi que você está em uma agência $trimmedName');
          notificationShown = true; // Mark notification as shown
        }
      }
    }
    setState(() {});
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Unique ID for your notification channel
      'Your Channel Name', // Name of your channel
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
    );
  }

  String generateRandomPassword() {
    final random = Random();
    return List.generate(3, (index) => random.nextInt(10)).join();
  }

  @override
  void dispose() {
    periodicTimer.cancel(); // Cancel the timer when the widget is disposed
    notificationShown = false; // Reset the notification status if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Olá, Lucas',
        style: TextStyle(color: kItauBlueColor),
      ),
      content: Text(
        'Acabei de notar que você está na agência $trimmedName',
        style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
      ),
      actions: [
        Center(
          child: Column(
            children: [
              Divider(),
              Text("O que você deseja fazer hoje?"),
              SizedBox(height: 20),
              if (showButtons) ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kItauBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      displayedPassword = generateRandomPassword();
                      showButtons = false;
                    });
                  },
                  child: Text(
                    "atendimento ao caixa",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kItauBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      displayedPassword = generateRandomPassword();
                      showButtons = false;
                    });
                  },
                  child: FittedBox(
                    child: Text(
                      "atendimento com gerente",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  'Sua senha é:',
                  style: TextStyle(
                    height: BorderSide.strokeAlignCenter,
                    fontSize: 20,
                    color: kItauBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$displayedPassword',
                  style: TextStyle(
                    height: BorderSide.strokeAlignCenter,
                    fontSize: 80,
                    color: kItauBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text(
                  'Fechar',
                  style: TextStyle(color: kItauBlueColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
