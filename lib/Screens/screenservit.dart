import 'package:flutter/material.dart';
import 'package:sam_app/Screens/catalogcard.dart';
import 'package:sam_app/Screens/items.dart';

class Screenservit extends StatelessWidget {
   const Screenservit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      appBar: AppBar(
        title: const Text("IT Services"),
        centerTitle: true,
        leading: Image.asset(
          "assets/images/A.png",
          width: 15,
          height: 15,
        ),
      ),
      body: Column(
        children: itservicedesks.map((e) => CatalogCard(catalogItem: e)).toList(),
      ),

    );
  }
}
