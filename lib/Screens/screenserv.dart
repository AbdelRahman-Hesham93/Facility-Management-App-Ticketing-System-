import 'package:flutter/material.dart';
import 'package:sam_app/Screens/catalogcard.dart';
import 'package:sam_app/Screens/items.dart';

class Screenserv extends StatelessWidget {
  const Screenserv({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Facility Services"),
        centerTitle: true,
        leading: Image.asset(
          "assets/images/A.png",
          width: 15,
          height: 15,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: servicedesks.map((e) => CatalogCard(catalogItem: e)).toList(),
        ),
      ),
    
    );
  }
}
