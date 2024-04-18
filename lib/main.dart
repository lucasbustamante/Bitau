import 'package:bitau/BLE/beacon.dart';
import 'package:bitau/widgetsPage.dart';
import 'package:flutter/material.dart';

import 'first_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetsPage(),
    );
  }
}
