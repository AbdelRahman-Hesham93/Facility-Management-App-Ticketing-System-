import 'package:flutter/material.dart';
import 'package:sam_app/Auth/auth_login.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthCode _authCode = AuthCode();
  bool _isLoading = false; // State variable for loading indicator

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      String? accessToken = await _authCode.signInWithMicrosoft();
      if (accessToken != null) {
        // Successful login, handle navigation or other logic here
      } else {
        // Handle login failure
      }
    } catch (e) {
      print("Error during sign-in with Microsoft: $e");
      // Handle errors, e.g., show a snackbar or dialog to the user
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
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
              _isLoading
                  ? const CircularProgressIndicator(semanticsLabel: 'Loading...')
                  : ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(25)))),
                      ),
                      onPressed: () {
                        // Add your onPressed logic here
                        _handleSignIn();
                      },
                      child: const Text(
                        "       Login       ",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
              Image.asset("assets/images/B.png", width: 200, height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
