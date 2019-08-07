import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

class FloorTitle extends StatelessWidget {
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}



class FloorContent extends StatelessWidget {

  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }


  Widget _firstRow(context){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0],context),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1],context),
            _goodsItem(floorGoodsList[2],context)
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3],context),
        _goodsItem(floorGoodsList[4],context)
      ],
    );
  }


  Widget _goodsItem(Map goods,context){
    return Container(
      width: ScreenUtil().setWidth(525),
      child: InkWell(
        onTap: ()=>Application.router.navigateTo(context, '/details?id=${goods['goodsId']}'),
        child: Image.network(goods['image']),
      ),
    );
  }
}





