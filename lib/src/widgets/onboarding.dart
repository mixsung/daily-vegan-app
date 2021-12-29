import 'package:daily_vegan_app/src/utils/onboarding_check.dart';
import 'package:daily_vegan_app/src/controller/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:daily_vegan_app/src/app.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
                titleWidget: Text('하루하루 기록하는 \n나만의 채식 일기',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NotoSerifKR'),
                    textAlign: TextAlign.center),
                bodyWidget: Icon(
                  Icons.maximize_outlined,
                  size: 70.0,
                  color: Colors.green,
                ),
                decoration: getPageDecoration()),
            PageViewModel(
                titleWidget: Text('목표로 하는 \n채식 유형을 알려주세요.',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSerifKR',
                    ),
                    textAlign: TextAlign.center),
                // title: '목표로 하는 채식 유형을 알려주세요.',
                bodyWidget: OnboardingCheck(),
                decoration: getPageDecorationSecond(),
                footer: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      padding: const EdgeInsets.only(right: 10),
                      onPressed: () {
                        _veganTypeModalSheet(context);
                      },
                    ),
                    Text(
                      '채식 유형 자세히',
                      style: TextStyle(
                          fontFamily: 'NotoSerifKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0),
                    )
                  ],
                )),
            PageViewModel(
                title: '목표한 채식을 위해 알림 설정을 해주세요.',
                bodyWidget: ElevatedButton(
                    onPressed: () {}, child: Text("잊지 말고 다이어리 알람 받기")),
                decoration: getPageDecorationSecond()),
            PageViewModel(
                title: '매일 하지 않아도 괜찮아요.',
                body: '그냥 기록해보세요.',
                footer: Container(
                  width: 300,
                  height: 300,
                  child: SignInScreen(),
                ),
                decoration: getPageDecorationSecond())
            // PageViewModel(
            //     title: '어떤 이유로 채식을 결심하게 되었나요?',
            //     bodyWidget: SingleChildScrollView(
            //       padding: EdgeInsets.only(top: 15.0),
            //       child: TextField(
            //         style: TextStyle(fontFamily: 'NotoSerifKR', fontSize: 15.0),
            //         maxLines: null,
            //         decoration: InputDecoration(
            //             border: InputBorder.none,
            //             contentPadding: EdgeInsets.symmetric(vertical: 40.0),
            //             hintText: ' 환경을 위해 결심하게 되었어요.',
            //             hintStyle: TextStyle(
            //                 fontFamily: 'NotoSerifKR', fontSize: 15.0)),
            //       ),
            //     )),
          ],
          showNextButton: true,
          showDoneButton: false,
          isProgress: false,
          freeze: false,
          next: Container(
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 50.0,
              color: Colors.black,
            ),
          ),
          onDone: () {},
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            fontFamily: 'NotoSerifKR'),
        bodyTextStyle: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            fontFamily: 'NotoSerifKR'),
        bodyAlignment: Alignment.center,
        titlePadding: EdgeInsets.only(top: 100),
        // footerPadding: EdgeInsets.only(top: 100.0),
      );

  PageDecoration getPageDecorationSecond() => PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'NotoSerifKR',
      ),
      bodyTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'NotoSerifKR',
      ));

  TextStyle getPageTextStyle() => TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'NotoSerifKR');

  void _veganTypeModalSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * .90,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel,
                                color: Colors.grey, size: 20))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('플렉시테리언(Flexitarian)', style: getPageTextStyle()),
                        Text('🐷 🐔 🐟 🥚 🥛 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('폴로베지테리언, 세미베지테리언', style: getPageTextStyle()),
                        Text('(Pollo-vegitarian, Semi-vegetarian)',
                            style: getPageTextStyle()),
                        Text('🐔 🐟 🥚 🥛 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('페스코베지테리언(Pescatarian)',
                            style: getPageTextStyle()),
                        Text('🐟 🥚 🥛 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('락토오보(Lacto-ovo-vegetarian)',
                            style: getPageTextStyle()),
                        Text('🥚 🥛 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('오보(Ovo-vegetarian)', style: getPageTextStyle()),
                        Text('🥚 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('락토(Lacto vegetarian)', style: getPageTextStyle()),
                        Text('🥛 🌿 🍎'),
                        SizedBox(height: 10),
                        Text('비건(Vegan)', style: getPageTextStyle()),
                        Text('🌿 🍎')
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
