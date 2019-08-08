import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:flutter_shop/provide/cartProvide.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[_cartCheckbtn(context),_cartImage(),_cartGoodName(),_cartPrice(context)],
      ),
    );
  }

  //复选按钮
  Widget _cartCheckbtn(context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  //商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(250),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodName() {
    return Container(
      width: ScreenUtil().setWidth(400),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item.goodsName),CartCount(item)],
      ),
    );
  }

  //
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
              child: InkWell(
            child: Icon(Icons.delete),
            onTap: () async {
              await Provide.value<CartProvide>(context).removeGood(item.goodsId);
            },
          ))
        ],
      ),
    );
  }
}
