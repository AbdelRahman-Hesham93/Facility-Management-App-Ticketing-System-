import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sam_app/globalvar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyMap extends StatefulWidget {
   const MyMap({Key? key}) : super(key: key);

  // const MyResturant({Key? key}) : super(key :key);
  @override
 State<MyMap> createState() => _MyMapstate();
 
}

class _MyMapstate extends State<MyMap> with TickerProviderStateMixin {
 late final WebViewController controller;
  
String url = "https://www.google.com/maps/d/u/0/viewer?hl=en&mid=15dOxCKae29Ck9U_Nvkxe3Xn3Zya1Gkd7";

 var loadingPercentage = 0;


    @override
  void initState() {
    super.initState();
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..loadRequest(Uri.parse('https://www.google.com/maps/d/u/0/viewer?hl=en&mid=15dOxCKae29Ck9U_Nvkxe3Xn3Zya1Gkd7'))
  ..setNavigationDelegate(
        
      NavigationDelegate(
        
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });

        },
      ),
       
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Samcrete Projects'),
      centerTitle: true,
           leading: Image.asset(
          "assets/images/A.png", // Replace with the path to your image asset
          width: 15, // Adjust the width as needed
          height: 15, // Adjust the height as needed
        ),),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://www.google.com/maps/d/u/0/viewer?hl=en&mid=15dOxCKae29Ck9U_Nvkxe3Xn3Zya1Gkd7'),
        ),
        onWebViewCreated: (controller) {
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          // Check if the URL is a special one indicating data to be passed
          final url = navigationAction.request.url;
          if (url!.scheme == 'flutterdata') {
            setState(() {
            });
            // uploadDataToFirestore(data); // Upload the received data to Firestore
            // return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) {
          // Handle onLoadStop if needed
        },
      ),

    );
  }
}

