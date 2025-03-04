import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sam_app/Auth/loginpage.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Screens/homepage.dart';
import 'package:sam_app/globalvar.dart';
import 'package:sam_app/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samcrete Service Desk',
      theme: ThemeData(
        primarySwatch: mainColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(76, 143, 78, 0.3),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class AuthenticationHandler extends StatelessWidget {
  final AuthCode _authCode = AuthCode();
  // final Future<List<String>> _adminEmailsFuture = const AdminEmails().fetchCollection('AdminEmails');

  AuthenticationHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authCode.authChanges(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            final user = snapshot.data;
            if (user != null) {
              return HomePage();
            }
            return const LoginScreen(); // Moved this line to handle the default case.
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
