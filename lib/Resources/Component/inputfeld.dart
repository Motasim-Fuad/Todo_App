import 'package:flutter/material.dart';

class InputFeld extends StatelessWidget {
  final  controler;
  final hindtext;
  const InputFeld({Key? key,required this.controler,required this.hindtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controler,

      style:const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hindtext.toString(),
        hintStyle:const TextStyle(color: Colors.black),

        border: OutlineInputBorder(
            borderSide:
           const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
      ),

    );
  }
}
