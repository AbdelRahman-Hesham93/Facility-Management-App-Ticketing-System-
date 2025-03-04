import 'package:flutter/material.dart';
import 'package:sam_app/globalvar.dart';
import 'package:sam_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add any initialization logic here if needed

    // Simulate a 5-second delay before navigating to the main screen
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to your main screen (e.g., AuthenticationHandler)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthenticationHandler(), // Replace with your main screen widget
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  mainColor,// Customize the background color
      body: 
        DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 76, 143, 78), Color.fromARGB(255, 62, 101, 48)],
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
              Image.asset("assets/images/A.png", width: 350, height: 350),
              const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
             const Text(
            "Loading...",
            // style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
            //   const Text(
            // "Please Wait",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
              Image.asset("assets/images/B.png", width: 200, height: 100),
          ],
        ),
      ),
    ),
    );
  }
}
