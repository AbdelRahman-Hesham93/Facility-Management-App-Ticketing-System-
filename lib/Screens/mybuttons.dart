import 'package:flutter/material.dart';
import 'package:sam_app/globalvar.dart';

class MyButton extends StatelessWidget {
  final String  txt;
  final VoidCallback onClick;
   final Widget icon;
  const MyButton({Key? key, required this.txt,  required this.onClick, required this.icon,}) : super(key :key);

 @override
Widget build(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
      onPressed: onClick,
      label:  Text(txt, style: const TextStyle(fontSize: 25),),
      
      icon: icon,
      
    ),
  );
}}