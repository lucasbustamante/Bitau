import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'BLE/ble_controller.dart';
import 'controller/colors.dart';
import 'widgets/bottomsheet.dart';
import 'widgets/containerWidgets.dart';
import 'widgets/downWidget.dart';
import 'widgets/popUp.dart';
import 'widgets/widgetNotification.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool showFloatingButton = false;
  bool popupDisplayed = false;
  DateTime? lastDetectionTime;
  late Timer periodicTimer;
  int rssiValue = 0;
  String name = "";
  String trimmedName = '';

  void _checkBluetoothResults(List<ScanResult> scanResults) {
    bool foundBeacon = false;

    for (var result in scanResults) {
      if (result.advertisementData.serviceUuids!.contains(
          '4fafc201-1fb5-459e-8fcc-c5c9c331914b')) {
        //if (result.device.name!.contains('DC3')) {
        rssiValue = result.rssi;
        //define distancia de atuação do beacon
        if (rssiValue >= -50) {
        int endIndex = name.indexOf(' ') + 1;
        trimmedName = name.substring(endIndex);
        name = result.device.name;
        foundBeacon = true;

        if (!popupDisplayed) {
          setState(() {
            showFloatingButton = true;
            popupDisplayed = true;
            lastDetectionTime =
                DateTime.now(); // Atualiza o momento da última detecção
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MenuPopup(); // Mostra o popup
            },
          );
        }

        if (!showFloatingButton) {
          setState(() {
            showFloatingButton = true;

            lastDetectionTime =
                DateTime.now(); // Atualiza o momento da última detecção
          });
        }

        break; // Encontrou o beacon, para a busca
      }
    }
    }

    // Verifica se o beacon foi perdido e mais de 10 segundos se passaram desde a última detecção
    if (!foundBeacon && showFloatingButton && lastDetectionTime != null) {
      final timeSinceLastDetection = DateTime.now().difference(lastDetectionTime!);
      if (timeSinceLastDetection.inSeconds > 10) {
        setState(() {
          showFloatingButton = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Get.put(BleController());

    periodicTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (!popupDisplayed) {
        Get.find<BleController>().scanDevices();
      }

      // Verifica se o beacon foi perdido e mais de 10 segundos se passaram desde a última detecção
      if (!showFloatingButton && popupDisplayed && lastDetectionTime != null) {
        final timeSinceLastDetection = DateTime.now().difference(lastDetectionTime!);
        if (timeSinceLastDetection.inSeconds > 10) {
          setState(() {

          });
        }
      }
    });

    Get.find<BleController>().scanResults.listen((List<ScanResult> scanResults) {
      _checkBluetoothResults(scanResults);
    });
  }

  @override
  void dispose() {
    periodicTimer.cancel(); // Cancela o timer ao encerrar a tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showFloatingButton
          ? ElevatedButton(

        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),

            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
        ),
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MenuPopup(); // Usa o widget que criamos para o conteúdo do popup
              },
            );
          },
          child: Text("Hey, vi que você está em uma agência", style: TextStyle(
            color: kItauBlueColor,
          ),))
          : null,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: kItauBlueColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(child: Text("LB", style: TextStyle(fontSize: 17,
                              color: Colors.black, fontWeight: FontWeight.w500))),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Olá, Lucas",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "agência ••99 conta •••24-4",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          context: context,
                          builder: (BuildContext context) {
                            return Bottom_Sheet();
                          },
                        );
                      },
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ContainerWidget(title: "acessar", icon: Icons.lock_outline),
                ///Cenario para testes
                WidgetNotification(),
                Row(
                  children: [
                    Expanded(child: ContainerWidget(title: "Pix e transferir", icon: Icons.pix)),
                    SizedBox(width: 15),
                    Expanded(child: ContainerWidget(title: "pagar", icon: Icons.clear_all_sharp)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: ContainerWidget(title: "extrato", icon: Icons.menu)),
                    SizedBox(width: 15),
                    Expanded(child: ContainerWidget(title: "cartões", icon: Icons.credit_card)),
                  ],
                ),
                DownWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
