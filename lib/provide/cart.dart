import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {

  String cartString = '[]';
  List<CartInfoModel> cartList = [];

  save(goodsId, goodsName, count, price, images) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    cartString = sharedPreferences.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    bool isHave = false;

    int ival = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> map = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(map);
      cartList.add(CartInfoModel.fromJson(map));
    }

    cartString = json.encode(tempList).toString();

    print(cartString);
    print(cartList);
    sharedPreferences.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartInfo');
    print('清空完成-----------------------------');
    notifyListeners();
  }


  getCartInfo() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    cartList = [];
    if(cartString == null){
      cartList = [];
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List);
      tempList.forEach((item){
        cartList.add(CartInfoModel.fromJson(item));
      });

    }
    notifyListeners();
  }
}
