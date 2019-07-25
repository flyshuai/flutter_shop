import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'package:flutter_shop/utils/adBanner.dart';
import 'package:flutter_shop/utils/leaderPhone.dart';
import 'package:flutter_shop/utils/swiper.dart';
import 'package:flutter_shop/utils/topNavigator.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = new TextEditingController();

  String homePageContent = '正在获取数据';

  void initState() {
    getHomePageContent().then((value) {
      setState(() {
        homePageContent = value.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('百姓生活+'),
            ),
            body: FutureBuilder(
                future: getHomePageContent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = json.decode(snapshot.data.toString());
                    List<Map> swiper = (data['data']['slides'] as List).cast();
                    List<Map> navigatorList = (data['data']['category'] as List).cast();
                    String adPictureUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
                    String leadImage = data['data']['shopInfo']['leaderImage'];
                    String leadPhone = data['data']['shopInfo']['leaderPhone'];
                    return Column(
                      children: <Widget>[
                        SwiperDiy(swiperDateList: swiper),
                        TopNavigator(navigatorList: navigatorList),
                        AdBanner(adPicture: adPictureUrl),
                        LeaderPhone(leaderImage: leadImage,leaderPhone: leadPhone,)
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('加载中。。。。'),
                    );
                  }
                })));
  }
}



