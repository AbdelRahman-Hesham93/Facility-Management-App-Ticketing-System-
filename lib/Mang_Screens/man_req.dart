import 'package:flutter/material.dart';
import 'package:sam_app/Mang_Screens/dropbutton_admin_requests.dart';

class ManRequests extends StatelessWidget {
  const ManRequests ({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: const Text("All Requests"),centerTitle: true,),
      body: const Center(child: Column(children:[ADropdownButtons()],)));
      
      
      
     
        
    //  SubmitButton(iconz: Icon(Icons.ac_unit), onPressed: onTap,)
     

    
  }
}

