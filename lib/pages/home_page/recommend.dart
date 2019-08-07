import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

class Recommend extends StatelessWidget {
  final List recommendList;

  const Recommend({Key key, this.recommendList}) : super(key: key);

  //标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pinkAccent),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index,context);
        },
      ),
    );
  }

  //商品单独项
  Widget _item(index,context) {
    final width = ScreenUtil.screenWidth;
    return InkWell(
      onTap: ()=>Application.router.navigateTo(context, '/details?id=${recommendList[index]['goodsId']}'),
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: ScreenUtil().setHeight(330),
        width:ScreenUtil().setWidth(250),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}
