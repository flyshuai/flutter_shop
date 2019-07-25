import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'package:flutter_shop/utils/adBanner.dart';
import 'package:flutter_shop/utils/floor.dart';
import 'package:flutter_shop/utils/leaderPhone.dart';
import 'package:flutter_shop/utils/recommend.dart';
import 'package:flutter_shop/utils/swiper.dart';
import 'package:flutter_shop/utils/topNavigator.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController typeController = new TextEditingController();
  var formData = {'lon': '115.02932', 'lat': '35.76189'};
  String homePageContent = '正在获取数据';
  int page = 1;
  List<Map> hotGoodsList = [];

  void initState() {
    getHomePageContent('homePageContent', formData: formData).then((value) {
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
                future:
                    getHomePageContent('homePageContent', formData: formData),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = json.decode(snapshot.data.toString());
                    List<Map> swiper = (data['data']['slides'] as List).cast();
                    List<Map> navigatorList =
                        (data['data']['category'] as List).cast();
                    String adPictureUrl =
                        data['data']['advertesPicture']['PICTURE_ADDRESS'];
                    String leadImage = data['data']['shopInfo']['leaderImage'];
                    String leadPhone = data['data']['shopInfo']['leaderPhone'];
                    List<Map> recommend =
                        (data['data']['recommend'] as List).cast();
                    String floor1Title =
                        data['data']['floor1Pic']['PICTURE_ADDRESS'];
                    String floor2Title =
                        data['data']['floor2Pic']['PICTURE_ADDRESS'];
                    String floor3Title =
                        data['data']['floor3Pic']['PICTURE_ADDRESS'];
                    List<Map> floor1 = (data['data']['floor1'] as List).cast();
                    List<Map> floor2 = (data['data']['floor2'] as List).cast();
                    List<Map> floor3 = (data['data']['floor3'] as List).cast();

                    return SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        SwiperDiy(swiperDateList: swiper),
                        TopNavigator(navigatorList: navigatorList),
                        AdBanner(adPicture: adPictureUrl),
                        LeaderPhone(
                          leaderImage: leadImage,
                          leaderPhone: leadPhone,
                        ),
                        Recommend(recommendList: recommend),
                        FloorTitle(picture_address: floor1Title),
                        FloorContent(floorGoodsList: floor1),
                        FloorTitle(picture_address: floor2Title),
                        FloorContent(floorGoodsList: floor2),
                        FloorTitle(picture_address: floor3Title),
                        FloorContent(floorGoodsList: floor3),
                        hotTitle
                      ],
                    ));
                  } else {
                    return Center(
                      child: Text('加载中。。。。'),
                    );
                  }
                })));
  }

  void _getHotGoods() {
    var formPage = {'page':page};
    getHomePageContent('homePageBelowConten',formData: formPage).then((value){
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
      child: Text('火爆专区'),
  );


  Widget _wrapList(){
    if(hotGoodsList.length!=0){
//      List<Widget> listWidget = hotGoodsList
    }
  }

  @override
  bool get wantKeepAlive => true; //保持页面状态
}
