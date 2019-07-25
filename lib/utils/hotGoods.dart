
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_methods.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {

  void initState(){
    super.initState();
    var formData = {
      'page':1
    };
    getHomePageContent('homePageBelowConten',formData: formData).then((value){
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('11111111111'),
    );
  }
}