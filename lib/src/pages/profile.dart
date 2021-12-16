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
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new Container(
              child: CircleAvatar(
                radius: 80,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(
                    'https://www.rd.com/wp-content/uploads/2019/04/avocado-shutterstock_1127284562.jpg'),
              ),
              width: 150.0,
              height: 150.0,
              padding: const EdgeInsets.all(1.0),
              decoration: new BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle),
            )
          ],
        ),
        ListTile(
          title: Center(
              child: Text('',
                  // Text('${auth.currentUser?.email}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSerifKR',
                      fontSize: 30,
                      color: Colors.black))),
          subtitle: Center(
              child: Text('페스코',
                  style: TextStyle(
                      fontFamily: 'NotoSerifKR',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.green))),
        ),
        SizedBox(height: 10),
        Divider(color: Colors.black, thickness: 0.8),
        ListTile(
            contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            title: Text('내 정보 변경',
                style: TextStyle(
                    fontFamily: 'NotoSerifKR',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 18)),
            onTap: () {}),
        Divider(color: Colors.black, thickness: 0.8),
        ListTile(
            contentPadding: EdgeInsets.only(left: 50.0),
            title: Text('문의',
                style: TextStyle(
                    fontFamily: 'NotoSerifKR',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 18)),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AskProfile()));
            }),
        Divider(color: Colors.black, thickness: 0.8),
        ListTile(
            contentPadding: EdgeInsets.only(left: 50.0),
            title: Text('로그아웃',
                style: TextStyle(
                    fontFamily: 'NotoSerifKR',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 18)),
            onTap: () {}),
        Divider(color: Colors.black, thickness: 0.8),
      ],
    );
  }
}
