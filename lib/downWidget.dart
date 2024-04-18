import 'package:flutter/material.dart';

class DownWidget extends StatelessWidget {
  const DownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return               Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.pix, color: Colors.white),
              Text("Pix", style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.keyboard_outlined, color: Colors.white),
              Text("iToken", style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.perm_device_information_sharp, color: Colors.white),
              Text("Ajuda", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
