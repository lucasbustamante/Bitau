import 'package:bitau/colors.dart';
import 'package:flutter/material.dart';

class MeuPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Olá, Lucas',style: TextStyle(
        color: kOrangeDarkColor
      ),),
      content: Text('Acabei de notar que você está na agencia ',
        style: TextStyle(
          fontSize: 15,
              color: Colors.grey.shade800
        ),),
      actions: [
        Center(
          child: Column(
            children: [
              Divider(),
              Text("O que você deseja fazer hoje?"),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kOrangeDarkColor,
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
                   
                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o popup
                },
                child: Text('Fechar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
