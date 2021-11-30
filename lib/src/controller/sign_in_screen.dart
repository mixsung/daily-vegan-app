import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:daily_vegan_app/src/components/google_signin_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 20.0, top: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              FutureBuilder(
                  future: Firebase.initializeApp(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Firebase load fail"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
