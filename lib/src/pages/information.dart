import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  List<Map<String, String>> datas = [];

  @override
  void initState() {
    super.initState();
    datas = [
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. ",
        "url":
            "https://boom-appeal-364.notion.site/5-dcc39efb2153419a9baa6f27b88d2c9a"
      },
      {
        "image": "assets/images/1.png",
        "title": "먹어본 식물성 우유 중 가장 베스트는?",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. ",
        "url":
            "https://boom-appeal-364.notion.site/5-dcc39efb2153419a9baa6f27b88d2c9a"
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
      {
        "image": "assets/images/1.png",
        "title": "당신이 페스코라면? 못참는 식당 5곳 추천",
        "description":
            "대체육 중에서는 탑이라고 할 수 있다. 기존 패티와 맛은 당연히 다르지만 못먹을 정도는 아니란 소리! 맛있게 먹으면 된거 아닌가?라면 이 대체육 패티를 사서 먹어보세요. "
      },
    ];
  }

  // flutter url_launcher
  // For Android
  // _launchURLBrowser() async {
  //   const url = 'url';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // For iOS
  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _bodyWidget() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return InkWell(
            onTap: () async {
              if (await canLaunch(datas[index]["url"].toString())) {
                await launch(datas[index]["url"].toString());
              } else {
                throw 'Could not launch ${datas[index]["url"].toString()}';
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(datas[index]["title"].toString(),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NotoSerifKR')),
                  SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(datas[index]["image"].toString(),
                              width: 100, height: 100),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(datas[index]["description"].toString(),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'NotoSerifKR')),
                          )
                        ]),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: datas.length,
        separatorBuilder: (BuildContext _context, int index) {
          return Container(height: 1, color: Colors.black.withOpacity(0.4));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _bodyWidget()));
  }
}
