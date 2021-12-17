import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;

  static const TextStyle optionStyle = TextStyle(
      fontSize: 20,
      fontFamily: 'NotoSerifKR',
      fontWeight: FontWeight.w700,
      color: Colors.black);

  static const TextStyle doneStyle = TextStyle(
      fontSize: 20,
      fontFamily: 'NotoSerifKR',
      fontWeight: FontWeight.w600,
      color: Colors.black);

  static const TextStyle veganStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'NotoSerifKR',
      fontWeight: FontWeight.w600,
      color: Colors.black);

  @override
  Widget build(BuildContext context) {
    // final oCcy = new NumberFormat("#, ###", "ko_KR");
    // String calcStringToWon(String priceString) {
    //   return "${oCcy.format(int.parse(priceString))}원";
    // }
    // 적용할 시
    // Text(calcStringToWon(datas[index["price"]]))

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(DateFormat("yyyy.MM.dd").format(DateTime.now()),
                style: optionStyle),
            SizedBox(height: 50.0),
            Row(children: <Widget>[
              TextButton(onPressed: () {}, child: Text('완료', style: doneStyle))
            ]),
            Divider(thickness: 1.0, color: Colors.black),
            // Container(),
            SizedBox(height: 100.0),
            Row(children: <Widget>[
              SizedBox(width: 150.0),
              Text('채식인가요?', style: veganStyle),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              )
            ]),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: '제목 또는 음식 이름',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NotoSerifKR',
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: '짧은 기록, 레시피를 적어도 좋아요.',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NotoSerifKR',
                            fontWeight: FontWeight.w400,
                            color: Colors.black))))
          ],
        ),
      )),
    );
  }
}
