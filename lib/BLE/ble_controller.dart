// Importações necessárias para o código
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// Controller para a funcionalidade BLE (Bluetooth Low Energy)
class BleController extends GetxController {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  // Método para solicitar permissões relacionadas ao Bluetooth
  Future<bool> _requestPermissions() async {
    final bluetoothStatus = await Permission.bluetoothScan.status;
    if (bluetoothStatus.isDenied) {
      // Solicita permissões de varredura e conexão Bluetooth se ainda não foram concedidas
      return await Permission.bluetoothScan.request().isGranted &&
          await Permission.bluetoothConnect.request().isGranted;
    }
    return true;
  }

  // Método para iniciar a varredura de dispositivos BLE
  Future<void> scanDevices() async {
    if (await _requestPermissions()) {
      flutterBlue.startScan(timeout: Duration(seconds: 4));
    } else {
      // Lide com o caso em que as permissões não foram concedidas
      print("Permissões Bluetooth não concedidas.");
    }
  }

  // Stream para obter os resultados da varredura
  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  Future<void> stopScan() async {
    await flutterBlue.stopScan();
  }
}