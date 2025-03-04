import 'package:flutter/material.dart';
import 'package:sam_app/Screens/homenavbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: false,
      
       
      body: 
            HBottomNavBar(),

     
               
    );
  }
}
