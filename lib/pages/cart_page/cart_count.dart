import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/provide/cartProvide.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  CartInfoModel item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(195.25),
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.topLeft,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_reduceBtn(context), _countArea(), _addBtn(context)],
      ),
    );
  }

  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).changeGoodsCount(item.goodsId,0);
      },
      child: Container(
        width: ScreenUtil().setWidth(55),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count>1?Colors.white:Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: item.count>1?Text('-'):Text(''),
      ),
    );
  }

  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).changeGoodsCount(item.goodsId,1);
      },
      child: Container(
        width: ScreenUtil().setWidth(55),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(item.count.toString()),
    );
  }
}
