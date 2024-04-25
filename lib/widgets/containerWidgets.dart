import 'package:flutter/material.dart';

import '../controller/colors.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? size;

  const ContainerWidget({super.key, required this.title, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: size == null ?  160 : size,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kOrangeDarkColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 30,),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 15),)
            ],
          ),
        ),
      ),
    )
    ;
  }
}
