import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/components/google_signin_button.dart';

class App extends StatelessWidget {
  // const App({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return FutureBuilder(
    //     future: Firebase.initializeApp(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text("Firebase load fail"),
    //         );
    //       }
    //
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return GoogleSignInButton();
    //       }
    //       return CircularProgressIndicator();
    //     }
    //     );
  }
}
