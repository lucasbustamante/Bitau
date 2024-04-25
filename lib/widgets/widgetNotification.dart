import 'dart:async';
import 'package:bitau/BLE/ble_controller.dart';
import 'package:bitau/controller/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class WidgetNotification extends StatefulWidget {
  const WidgetNotification({Key? key}) : super(key: key);

  @override
  _WidgetNotificationState createState() => _WidgetNotificationState();
}

class _WidgetNotificationState extends State<WidgetNotification> {
  bool close = false;
  int rssiValue = 0;
  String name = "";
  late Timer periodicTimer;
  bool popupDisplayed = false;
  String trimmedName = '';

  _checkBluetoothResults(List<ScanResult> scanResults) {

    for (var result in scanResults) {
      if (result.device.name!.contains('DC3')) {
        rssiValue = result.rssi;
        int endIndex = name.indexOf(' ') + 1;
        trimmedName = name.substring(endIndex);
        name = result.device.name;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Get.put(BleController());

    // Inicia o timer para verificações periódicas
    periodicTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (!popupDisplayed) {
        Get.find<BleController>().scanDevices();
      }
    });

    Get.find<BleController>().scanResults.listen((List<ScanResult> scanResults) {
      _checkBluetoothResults(scanResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return close ? Container() : Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Define a duração da animação
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Row(
                    children: [
                      Text(";D", style: TextStyle(fontSize: 30, color: kOrangeDarkColor),),
                      SizedBox(width: 20),
                      Container(
                        width: MediaQuery.of(context).size.width*0.53,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text("Beacon, fazendo o futuro", style: TextStyle(
                                fontSize: 18, color: kOrangeDarkColor, fontWeight: FontWeight.w500
                              ),),
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              child: Text("Agência: $trimmedName", style: TextStyle(
                                fontSize: 15,
                              ),),
                            ),
                            FittedBox(
                              child: Text("Distancia: $rssiValue", style: TextStyle(
                                fontSize: 15,
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ), // Conteúdo da primeira parte do container
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close, size: 18, color: kOrangeDarkColor),
                      onPressed: () {
                        setState(() {
                          close = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
