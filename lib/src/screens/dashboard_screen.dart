import 'package:firebase_auth/firebase_auth.dart';
import 'package:daily_vegan_app/src/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/screens/add_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddScreen(),
          ));
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 20.0, top: 16.0),
          // FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //   if (user == null) {
          //     return Text('아직 게시물이 없습니다.') ;
          //   }
          // });
          child: ItemList(),
        ),
      ),
    );
  }
}
