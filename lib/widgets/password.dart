import 'package:bitau/controller/colors.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Olá, Lucas',style: TextStyle(
          color: kItauBlueColor
      ),),
      content: Text('',
        style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade800
        ),),
      actions: [
        Center(
          child: Column(
            children: [
              Divider(),
              Text("O quje?"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kItauBlueColor,
                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                },
                child: Text(
                  "atendimento ao caixa",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kItauBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                },
                child: FittedBox(
                  child: Text(
                    "atendimento com gerente",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o popup
                },
                child: Text('Fechar', style: TextStyle(
                    color: kItauBlueColor
                ),),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
