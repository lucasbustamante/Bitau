import 'package:bitau/colors.dart';
import 'package:flutter/material.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Center(child: Text("LB")),
                  ),
                  Text("Olá, Lucas\nagência 8499 conta 16924-4"),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
              Container(
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
