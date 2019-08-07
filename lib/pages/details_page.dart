import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('商品详情页'),
      ),

      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context,snapshot){
        if(snapshot.hasData){
          return Container(
            child: Column(
              children: <Widget>[

              ],
            ),
          );
        }else{
          return Container(
            child: Text('加载中。。。'),
          );
        }
      }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodDetails(goodsId);
    return '完成加载';
  }
}
