import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cartProvide.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Provide<CartProvide>(builder: (context, child, data) {
          return Row(
            children: <Widget>[
              _selectAllBtn(context),
              _allPriceArea(context),
              _goButton(context)
            ],
          );
        }));
  }

  Widget _selectAllBtn(context) {
    bool isAllChecked = Provide.value<CartProvide>(context).isAllChecked;
    return Container(
        child:Row(
          children: <Widget>[
            Checkbox(
                value: isAllChecked,
                onChanged: (bool val) {
                  Provide.value<CartProvide>(context).changeAllCheckBtn(val);
                },
                activeColor: Colors.pink),
            Text('全选')
          ],
        )
    );
  }

  Widget _allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(600),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
//                padding: EdgeInsets.only(left: 50),
                width: ScreenUtil().setWidth(300),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(300),
                child: Text(
                  '￥:${allPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(40), color: Colors.pink),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(600),
            alignment: Alignment.centerRight,
            child: Text(
              '满十元免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(30)),
            ),
          )
        ],
      ),
    );
  }

  Widget _goButton(context) {
    int allCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(260),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {

        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算（${allCount}）',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
