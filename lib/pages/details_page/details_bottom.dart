import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/cartProvide.dart';
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
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  width: ScreenUtil().setWidth(200),
                  alignment: Alignment.center,
                  child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
                ),
              ),
              Provide<CartProvide>(
                builder: (context,child,val){
                  int goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                  return Positioned(
                    top: 0.0,
                    right: 10.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(width: 2,color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Text(goodsCount.toString(),style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, images);
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
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
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
