import 'dart:async';

import 'package:bitau/BLE/ble_controller.dart';
import 'package:bitau/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class MenuPopup extends StatefulWidget {


  @override
  State<MenuPopup> createState() => _MenuPopupState();
}

class _MenuPopupState extends State<MenuPopup> {

  bool close = false;
  int rssiValue = 0;
  String agencia = "";
  late Timer periodicTimer;
  bool popupDisplayed = false;

  _checkBluetoothResults(List<ScanResult> scanResults) {

    for (var result in scanResults) {
      if (result.device.name?.toLowerCase() == 'esp32 beacon test') {
        rssiValue = result.rssi;
        agencia = result.device.name;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Get.put(BleController());

    // Inicia o timer para verificações periódicas
    var periodicTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
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
    return AlertDialog(
      title: Text('Olá, Lucas',style: TextStyle(
        color: kOrangeDarkColor
      ),),
      content: Text('Acabei de notar que você está na agencia $agencia',
        style: TextStyle(
          fontSize: 15,
              color: Colors.grey.shade800
        ),),
      actions: [
        Center(
          child: Column(
            children: [
              Divider(),
              Text("O que você deseja fazer hoje?"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kOrangeDarkColor,
                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
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

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o popup
                },
                child: Text('Fechar', style: TextStyle(
                  color: kOrangeDarkColor
                ),),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
