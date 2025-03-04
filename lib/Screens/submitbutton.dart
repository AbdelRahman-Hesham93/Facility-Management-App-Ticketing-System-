import 'package:flutter/material.dart';


class SubmitButton extends StatelessWidget {
 const SubmitButton({Key? key,  required this.iconz, required Null Function() onPressed,  required this.onTap, }) : super(key :key);
 final Icon iconz;
final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton.small(onPressed:onTap , child: iconz);


  }
}