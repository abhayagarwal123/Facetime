import 'package:flutter/material.dart';

class homebutton extends StatelessWidget{
   homebutton({super.key,required this.title,required this.function,required this.icon});
  String title;
  VoidCallback function;
Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: function, icon: icon, ),
        Text(title,style: TextStyle(fontSize: 20),)
      ],
    );
  }
}