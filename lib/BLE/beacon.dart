import 'dart:async';
import 'package:bitau/BLE/ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Inicia um timer para periodicamente solicitar a varredura de dispositivos
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      Get.find<BleController>().scanDevices();
    });
  }

  @override
  void dispose() {
    // Cancela o timer quando o widget é descartado
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE SCANNER"),  // Título da barra de aplicativo
        centerTitle: true,
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Constrói a lista de dispositivos encontrados
              StreamBuilder<List<ScanResult>>(
                stream: controller.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Filtra dispositivos com o nome "esp32"
                    final esp32Devices = snapshot.data!
                        .where((data) => data.device.name?.toLowerCase().contains('esp32') ?? false)
                        .toList();

                    if (esp32Devices.isNotEmpty) {
                      // Mostra a lista de dispositivos ESP32
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: esp32Devices.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(esp32Devices[index].device.name ?? ''),
                            subtitle: Text(esp32Devices[index].device.id.id),
                            trailing: Text(esp32Devices[index].rssi.toString(), style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      );
                    } else {
                      // Reinicia o timer se nenhum dispositivo ESP32 for encontrado
                      _timer.cancel();
                      _timer = Timer.periodic(Duration(seconds: 3), (_) {
                        Get.find<BleController>().scanDevices();
                      });

                      return Center(child: Text("Nenhum dispositivo ESP32 encontrado"));
                    }
                  } else {
                    // Mostra uma mensagem durante a varredura
                    return Center(child: Text("Varrendo..."));
                  }
                },
              ),
              SizedBox(height: 15),  
            ],
          ),
        ),
      ),
    );
  }
}