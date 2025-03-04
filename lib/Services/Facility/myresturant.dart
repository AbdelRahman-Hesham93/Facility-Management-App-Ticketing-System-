import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sam_app/globalvar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyRestaurant extends StatefulWidget {
   const MyRestaurant({Key? key}) : super(key: key);

  // const MyResturant({Key? key}) : super(key :key);
  @override
 State<MyRestaurant> createState() => _MyRestaurantstate();
 
}

class _MyRestaurantstate extends State<MyRestaurant> with TickerProviderStateMixin {
 late final WebViewController controller;
  
String url = "https://samcrete.smartmenues.com";

 var loadingPercentage = 0;


    @override
  void initState() {
    super.initState();
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..loadRequest(Uri.parse('https://samcrete.smartmenues.com'))
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
        title: const Text('Samcrete Resturant'),
       centerTitle: true,
           leading: Image.asset(
          "assets/images/A.png", // Replace with the path to your image asset
          width: 15, // Adjust the width as needed
          height: 15, // Adjust the height as needed
        ),),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://samcrete.smartmenues.com'),
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
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: const Icon(Icons.home_filled),
      //   label: const Text('Home'),
      //   onPressed: () {
      //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
      // return const HomePage();
      //       }),
      //     );
      //   },
      // ),
    );
  }
}

