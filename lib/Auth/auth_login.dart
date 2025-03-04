  import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:aad_oauth/model/failure.dart';
import 'package:aad_oauth/model/token.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

  // ... 

//    final Config config =  Config(
//     tenant: "YOUR_TENANT_ID",
//     clientId: "YOUR_CLIENT_ID",
//     scope: "openid profile offline_access",
//     // redirectUri is Optional as a default is calculated based on app type/web location
//     redirectUri: "your redirect url available in azure portal",
//     navigatorKey: navigatorKey,
//     webUseRedirect: true, // default is false - on web only, forces a redirect flow instead of popup auth
//     //Optional parameter: Centered CircularProgressIndicator while rendering web page in WebView
//     loader: const Center(child: CircularProgressIndicator()),
//     postLogoutRedirectUri: 'http://your_base_url/logout', //optional
//   );

//   final AadOAuth oauth =  AadOAuth(config);

//   final result = await oauth.login();
// result.fold(
//   (failure) => showError(failure.toString()),
//   (token) => showMessage('Logged in successfully, your access token: $token'),
// );
// String accessToken = await oauth.getAccessToken();

final _microsoftSignIn = AadOAuth(Config(
    // If you dont have a special tenant id, use "common"
    tenant: "common",
    clientId: "your-client-id",
    // Replace this with your client id ("Application (client) ID" in the Azure Portal)
    responseType: "code",
    scope: "User.Read",
    redirectUri: "msal{YOUR-CLIENT-ID-HERE}://auth",
    loader: const Center(child: CircularProgressIndicator()),
    navigatorKey: navigatorKey,
  ));

  _loginWithMicrosoft() async {
    var result = await _microsoftSignIn.login();

    result.fold(
      (Failure failure) {
        // Auth failed, show error
      },
      (Token token) async {
        if (token.accessToken == null) {
          // Handle missing access token, show error or whatever
          return;
        }

        // Handle successful login
        print('Logged in successfully, your access token: ${token.accessToken!}');

        // Perform necessary actions with the access token, such as API calls or storing it securely.

        await _microsoftSignIn.logout();
      },
    );
  }