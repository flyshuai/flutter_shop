//首页轮播组件
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperDiy extends StatelessWidget {


  final List swiperDateList;

  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print('设备像素密度：${ScreenUtil.pixelRatio}');
//    print('设备的高：${ScreenUtil.screenHeight}');
//    print('设备的宽：${ScreenUtil.screenWidth}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(1080),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: ()=>Application.router.navigateTo(context, '/details?id=${swiperDateList[index]['goodsId']}'),
            child: Image.network("${swiperDateList[index]['image']}"),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}