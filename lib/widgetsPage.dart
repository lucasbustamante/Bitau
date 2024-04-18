import 'package:bitau/colors.dart';
import 'package:bitau/widgets/containerWidgets.dart';
import 'package:bitau/widgets/downWidget.dart';
import 'package:bitau/widgets/widgetNotification.dart';
import 'package:flutter/material.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [kPrimaryColor, kSecondaryColor]
            )
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Center(child: Text("LB", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Olá, Lucas",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold, fontSize: 16
                              ),),Text("agência 8499 conta 16924-4",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.w500, fontSize: 14
                              ),),

                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                  ],
                ),
                SizedBox(height: 20),
                ContainerWidget(title: "acessar",icon: Icons.lock_outline,),
                WidgetNotification(),
                Row(
                  children: [
                    Expanded(child: ContainerWidget(title: "Pix e transferir",icon: Icons.pix,)),
                    SizedBox(width: 15),
                    Expanded(child: ContainerWidget(title: "pagar",icon: Icons.clear_all_sharp,)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: ContainerWidget(title: "extrato",icon: Icons.menu,)),
                    SizedBox(width: 15),
                    Expanded(child: ContainerWidget(title: "cartões",icon: Icons.credit_card,)),
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
