import 'package:flutter/material.dart';
import 'package:bitau/colors.dart';

class WidgetNotification extends StatefulWidget {
  const WidgetNotification({Key? key}) : super(key: key);

  @override
  _WidgetNotificationState createState() => _WidgetNotificationState();
}

class _WidgetNotificationState extends State<WidgetNotification> {
  bool close = false;

  @override
  Widget build(BuildContext context) {
    return close ? Container() : Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Define a duração da animação
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Row(
                    children: [
                      Text(";D", style: TextStyle(fontSize: 30, color: kOrangeDarkColor),),
                      SizedBox(width: 20),
                      Container(
                        width: MediaQuery.of(context).size.width*0.53,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text("Beacon, fazendo o futuro", style: TextStyle(
                                fontSize: 18, color: kOrangeDarkColor, fontWeight: FontWeight.w500
                              ),),
                            ),
                            Flexible(
                              child: Text("Teste de distancia Beacon: ", style: TextStyle(
                                fontSize: 15,
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ), // Conteúdo da primeira parte do container
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close, size: 18, color: kOrangeDarkColor),
                      onPressed: () {
                        setState(() {
                          close = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
