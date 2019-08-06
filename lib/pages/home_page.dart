import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'package:flutter_shop/utils/adBanner.dart';
import 'package:flutter_shop/utils/floor.dart';
import 'package:flutter_shop/utils/leaderPhone.dart';
import 'package:flutter_shop/utils/recommend.dart';
import 'package:flutter_shop/utils/swiper.dart';
import 'package:flutter_shop/utils/topNavigator.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
  var _getHomePageContent;

  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  void initState() {
    _getHomePageContent =
        request('homePageContent', formData: formData);

    _getHotGoods();
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
                future: _getHomePageContent,//使用变量形式防止重复刷新
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

                    return EasyRefresh(//上拉加载
                      //自定义加载效果
                      refreshFooter: ClassicsFooter(
                        bgColor: Colors.white,
                        textColor: Colors.pink,
                        moreInfoColor: Colors.pink,
                        showMore: true,
                        noMoreText: '',
                        moreInfo: '加载中',
                        loadReadyText: '上拉加载',
                        key: _footerKey,
                      ),

                      child: ListView(
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
                          _hotGoods()
//                          _hotGoods()
                        ],
                      ),
                      loadMore: () async {
                        print('开始加载更多。。。。');
                        _getHotGoods();
                      },
                    );
                  } else {
                    return Center(
                      child: Text('加载中。。。。'),
                    );
                  }
                })));
  }

  void _getHotGoods() {
    var formPage = {'page': page};
    request('homePageBelowConten', formData: formPage).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
      print(newGoodsList);
    });
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/details?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(500),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26.0)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['mallPrice']}',
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 1,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  @override
  bool get wantKeepAlive => true; //保持页面状态
}
