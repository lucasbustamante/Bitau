import 'package:bitau/widgets/containerWidgets.dart';
import 'package:flutter/material.dart';

class DownWidget extends StatelessWidget {
  final bool? container;

  const DownWidget({super.key, this.container});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          container == false ? Column(
            children: [
              Icon(Icons.pix, color: Colors.white),
              Text("Pix", style: TextStyle(color: Colors.white)),
            ],
          ) : Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 2.5),
                child: ContainerWidget(title: "Pix", icon: Icons.pix, size: 110),
              )),
          container == false ? Column(
            children: [
              Icon(Icons.keyboard_outlined, color: Colors.white),
              Text("iToken", style: TextStyle(color: Colors.white)),
            ],
          ) :
          Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: ContainerWidget(title: "iToken", icon: Icons.keyboard_outlined, size: 110),
          )),
          container == false ? Column(
            children: [
              Icon(Icons.perm_device_information_sharp, color: Colors.white),
              Text("Ajuda", style: TextStyle(color: Colors.white)),
            ],
          ) :
          Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2.5),
            child: ContainerWidget(title: "Ajuda", icon: Icons.perm_device_information_sharp, size: 110,),
          )),
        ],
      ),
    );
  }
}
