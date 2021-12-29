import 'package:daily_vegan_app/src/widgets/google_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보 변경',
            style: TextStyle(
                fontFamily: 'NotoSerifKR', fontWeight: FontWeight.w600)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
          ),
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
                      Text("${snapshot.data!.displayName}님 반갑습니다."),
                      TextButton(
                          child: Text('로그아웃'),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          }),
                      Text("${snapshot.data!.email}.입니다"),
                    ],
                  ));
                }
              }),
          // ListTile(
          //     contentPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          //     title: Text('닉네임',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontFamily: 'NotoSerifKR',
          //             fontWeight: FontWeight.w700)),
          //     subtitle: Text('f',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontFamily: 'NotoSerifKR',
          //             fontWeight: FontWeight.w500))),
          // ListTile(
          //     contentPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          //     title: Text('내 계정',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontFamily: 'NotoSerifKR',
          //             fontWeight: FontWeight.w700)),
          //     subtitle: Text('f',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontFamily: 'NotoSerifKR',
          //             fontWeight: FontWeight.w500))),
          ElevatedButton(
              onPressed: () {},
              child: Text('저장',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'NotoSerifKR',
                      fontWeight: FontWeight.w700)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
