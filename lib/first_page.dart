import 'package:flutter/material.dart';

import 'colors.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _agenciaController = TextEditingController();
  TextEditingController _contaController = TextEditingController();
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Redimensiona para evitar que o teclado cubra o conteúdo
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor,
                kSecondaryColor,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Image.asset(
                "assets/logo.png",
                width: MediaQuery.of(context).size.width * 0.13,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 40,
              ),
              Text(
                "Itaú Shop",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Compre pelo app com parcelas sem juros \ne ganhe cashback. Aproveite!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _agenciaController,
                                  onChanged: (value) {
                                    setState(() {

                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'agência',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _contaController,
                                  onChanged: (value) {
                                    setState(() {

                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'conta',

                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Switch(
                                  activeTrackColor: kPrimaryColor,
                                  inactiveTrackColor: kDisableColor,
                                  inactiveThumbColor: Colors.white,
                                  value: _isSwitched, onChanged: (value){
                                setState(() {
                                  _isSwitched = value;
                                });
                              }),
                              SizedBox(width: 10),
                              Text("lembrar agência e conta"),

                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(),
                              onPressed: (){},
                              child: Text("ok"))
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 20),
              Padding(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
