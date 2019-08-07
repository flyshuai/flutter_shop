import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).detailsModel.data.goodInfo;
        if(goodsInfo != null){
          return Container(
            color: Colors.white,
              child: Column(
                children: <Widget>[
                  _goodsImage(goodsInfo.image1),
                  _goodsName(goodsInfo.goodsName),
                  _goodsNum(goodsInfo.amount),
                  _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
                ],
              ),
          );
        }else{
          return Text('正在加载中');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(1100),
      height: ScreenUtil().setHeight(800),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(900),
      child: Text(
        name,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(900),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号:${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(price, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(900),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '￥${price}',
              style: TextStyle(fontSize: 25, color: Colors.deepOrange),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '市场价：￥${oriPrice}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black12),
            ),
          )
        ],
      ),
    );
  }
}
