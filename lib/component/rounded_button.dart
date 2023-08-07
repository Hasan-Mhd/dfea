import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton(
      {super.key,
      required this.colour,
      required this.title,
      required this.onPressed,
      required this.textColour});
  late Color colour;
  late String title;
  late VoidCallback onPressed;
  late Color textColour;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: widget.colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: widget.onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.textColour,
            ),
          ),
        ),
      ),
    );
  }
}
