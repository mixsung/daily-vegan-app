import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_vegan_app/src/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecificScreen extends StatefulWidget {
  final String currentName;
  final String currentRecipe;
  final String documentId;
  final String docDate;
  final String photoUrl;

  SpecificScreen({
    required this.currentName,
    required this.currentRecipe,
    required this.documentId,
    required this.docDate,
    required this.photoUrl,
  });

  @override
  _SpecificScreenState createState() => _SpecificScreenState();
}

class _SpecificScreenState extends State<SpecificScreen> {
  // final oCcy = new NumberFormat("#, ###", "ko_KR");
  // String calcStringToWon(String priceString) {
  //   return "${oCcy.format(int.parse(priceString))}원";
  // }
  // 적용할 시
  // Text(calcStringToWon(datas[index["price"]]))
  // String createdDateString = DateFormat('yyyy.M.d', 'ko').format();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: Column(
                children: [
                  // DateTime dt = DateTime.parse(widget.docDate);
                  //   print(dt);
                  SizedBox(height: 24.0),
                  Text(widget.docDate),
                  SizedBox(height: 8.0),
                  Container(
                      child: Image.network(widget.photoUrl, fit: BoxFit.fill),
                      width: 90),
                  Text(widget.currentName,
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0)),
                  SizedBox(height: 24.0),
                  SizedBox(height: 8.0),
                  Text(widget.currentRecipe,
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0)),
                  Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditScreen(
                                currentName: widget.currentName,
                                currentRecipe: widget.currentRecipe,
                                documentId: widget.documentId,
                                photoUrl: widget.photoUrl)));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'NotoSerifKR',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
