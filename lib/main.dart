import 'package:daily_vegan_app/src/mainPage.dart';
import 'package:daily_vegan_app/src/widgets/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/utils/onboarding_preferences.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

bool _isFirst = true;
Future OnboardingBinding() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await OnboardingPreferences.init();
}

@override
void main() async {
  await OnboardingBinding();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst = prefs.getBool('isFirst') ?? true;
  _isFirst = isFirst;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initializeDateFormatting().then((_) => runApp(MyApp()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var activity;
    if (_isFirst) {
      activity = OnBoarding();
      setFirst();
    } else {
      activity = MainPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //onboarding에서 최초 실행여부 체크 필요. onboarding()과 app()
      home: activity,
    );
  }

  setFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', false);
  }
}
