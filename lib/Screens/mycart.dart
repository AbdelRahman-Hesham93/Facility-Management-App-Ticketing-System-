

import 'package:flutter/material.dart';
import 'package:sam_app/Screens/dropbutton.dart';

class AllRequest extends StatelessWidget {
  const AllRequest ({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: const Text("My Requests"),centerTitle: true,),
      body: const Center(child: Column(children:[DropdownButtons()],)));
      
      
      
     
        
    //  SubmitButton(iconz: Icon(Icons.ac_unit), onPressed: onTap,)
     

    
  }
}