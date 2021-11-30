import 'package:daily_vegan_app/src/app.dart';
import 'package:daily_vegan_app/src/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/utils/onboarding_preferences.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await OnboardingPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //onboarding에서 최초 실행여부 체크 필요. onboarding()과 app()
      home: OnBoarding(),
    );
  }
}
