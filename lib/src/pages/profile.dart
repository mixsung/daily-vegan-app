import 'package:daily_vegan_app/src/components/google_signin_button.dart';
import 'package:daily_vegan_app/src/pages/ask_profile.dart';
import 'package:daily_vegan_app/src/pages/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:daily_vegan_app/src/controller/authentication.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50.0),
        StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (!snapshot.hasData) {
                return GoogleSignInButton();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      snapshot.data!.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color: Colors.white,
                                child: Image.network(snapshot.data!.photoURL!,
                                    fit: BoxFit.fitHeight),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.person,
                                      size: 60, color: Colors.white),
                                ),
                              ),
                            ),
                      SizedBox(height: 50.0),
                      Text("${snapshot.data!.displayName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'NotoSerifKR',
                              fontSize: 20,
                              color: Colors.black)),
                      SizedBox(height: 20.0),
                      Divider(color: Colors.black, thickness: 0.8),
                      TextButton(
                          child: Text('로그아웃',
                              style: TextStyle(
                                  fontFamily: 'NotoSerifKR',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 18)),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          }),
                    ],
                  ),
                );
              }
            }),
        // ListTile(
        //   title: Center(
        //       child: Text('랜덤이름',
        //           style: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontFamily: 'NotoSerifKR',
        //               fontSize: 30,
        //               color: Colors.black))),
        //   subtitle: Center(
        //       child: Text('페스코',
        //           style: TextStyle(
        //               fontFamily: 'NotoSerifKR',
        //               fontWeight: FontWeight.w700,
        //               fontSize: 20,
        //               color: Colors.green))),
        // ),
        // ListTile(
        //     contentPadding: EdgeInsets.only(left: 50.0),
        //     title: Text('문의',
        //         style: TextStyle(
        //             fontFamily: 'NotoSerifKR',
        //             fontWeight: FontWeight.w700,
        //             color: Colors.black,
        //             fontSize: 18)),
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => AskProfile()));
        //     }),
      ],
    );
  }
}
