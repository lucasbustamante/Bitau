import 'package:bitau/widgets/downWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _isSwitched = false;
  bool _isAgenciaFilled = false;
  bool _isContaFilled = false;

  final TextEditingController _agenciaController = TextEditingController();
  final TextEditingController _contaController = TextEditingController();
  final FocusNode _agenciaFocusNode = FocusNode();
  final FocusNode _contaFocusNode = FocusNode();

  @override
  void dispose() {
    _agenciaController.dispose();
    _contaController.dispose();
    _agenciaFocusNode.dispose();
    _contaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                              flex: 2,
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4), // 4 dígitos + 1 traço
                                  FilteringTextInputFormatter.digitsOnly,
                                  _CustomInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                controller: _agenciaController,
                                focusNode: _agenciaFocusNode,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgenciaFilled = value.length == 5 && value.contains('-');
                                  });
                                  if (value.length == 4) {
                                    _contaFocusNode.requestFocus();
                                    _isAgenciaFilled = true;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Agência',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(7), // 6 dígitos + 1 traço
                                  FilteringTextInputFormatter.digitsOnly,
                                  _CustomInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                controller: _contaController,
                                focusNode: _contaFocusNode,
                                onChanged: (value) {
                                  setState(() {
                                    _isContaFilled = value.length == 7 && value.contains('-');
                                  });
                                  if (value.length == 7) {
                                    _contaFocusNode.requestFocus();
                                    _isContaFilled = true;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Conta',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Switch(
                              activeTrackColor: kPrimaryColor,
                              inactiveTrackColor: kDisableColor,
                              inactiveThumbColor: Colors.white,
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text("Lembrar agência e conta"),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _isAgenciaFilled && _isContaFilled ? kPrimaryColor : kDisableColor,
                            minimumSize: Size(MediaQuery.of(context).size.width, 50), 
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            "ok",
                            style: TextStyle(
                              fontSize: 18,
                              color: _isAgenciaFilled && _isContaFilled ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DownWidget(container: false)
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    if (text.length == 6 && !text.contains('-')) {
      final formattedText = '${text.substring(0, 5)}-${text.substring(5)}';
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    return newValue;
  }
}
