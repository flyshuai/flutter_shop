import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(1100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(200),
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () async {
             await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              width: ScreenUtil().setWidth(450),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () async {await Provide.value<CartProvide>(context).remove();},
            child: Container(
              width: ScreenUtil().setWidth(450),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      color: Colors.white,
      height: ScreenUtil().setHeight(100),
    );
  }
}
