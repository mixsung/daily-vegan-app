import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCheck extends StatefulWidget {
  @override
  _OnboardingCheckState createState() => _OnboardingCheckState();
}

class _OnboardingCheckState extends State<OnboardingCheck> {
  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(key, message);
  }

  String? checkboxListValue;
  List<String> checkboxList = ["플렉시", "폴로", "페스코", "락토오보", "오보", "락토", "비건"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        children: this
            .checkboxList
            .map<Widget>((String v) => Container(
                  width: 200.0,
                  child: ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(v,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'NotoSerifKR',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700)),
                      onChanged: (bool? check) {
                        print(check);
                        setState(() => this.checkboxListValue = v);
                        print(checkboxListValue);
                        //
                        // final prefs = await SharedPreferences.getInstance();
                        // prefs.setString('checkValue', checkboxListValue!);
                        saveStr('checkValue', checkboxListValue!);
                      },
                      value: this.checkboxListValue == v ? true : false,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
