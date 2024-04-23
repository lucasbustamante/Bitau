import 'package:bitau/colors.dart';
import 'package:bitau/first_page.dart';
import 'package:flutter/material.dart';

class Bottom_Sheet extends StatelessWidget {
  const Bottom_Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: IntrinsicHeight(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contas Salvas",
                    style: TextStyle(fontSize: 17),
                  ),
                  Row(
                    children: [
                      Icon(Icons.mode_edit_outline_outlined, color: Colors.grey.shade800,),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Fechar o BottomSheet
                        },
                        child: Icon(Icons.close,color: Colors.grey.shade800,),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "LB",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LUCAS DA COSTA BUSTAMANTE",style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 15
                          ),),
                          Text("Agência ••99 Conta •••24-4", style: TextStyle(
                            color: Colors.grey.shade500
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.lock_outline)
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: kItauBlueColor
                      ),
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                },
                child: Text(
                  "não sou cliente",
                  style: TextStyle(
                    fontSize: 18,
                    color: kItauBlueColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    primary: kOrangeDarkColor,
                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()),
                  );
                },
                child: Text(
                  "novo acesso",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}