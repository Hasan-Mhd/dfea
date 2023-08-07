import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(this.text, this.logo, this.texType, this.visible, this.variable, {super.key});

  String? text;
  late IconData logo;
  late TextInputType texType;
  late bool visible;
  late void Function(String?) variable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 500,
      child: Scaffold(
        body: TextField(
          onChanged: variable,
          obscureText: visible,
          keyboardType: texType,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFf3f2f1),
              icon: Icon(
                logo,
                color: const Color(0xFFfeb800),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              labelText: text,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFFfeb800),
                ),
              )),
        ),
      ),
    );
  }
}
