import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('문의',
              style: TextStyle(
                  fontFamily: 'NotoSerifKR', fontWeight: FontWeight.w600)),
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('문의는 avacado@gmail.com 으로 해주세요.',
              style: TextStyle(
                  fontFamily: 'NotoSerifKR',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0)),
        ));
  }
}
