import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //商品总价格
  int allGoodsCount = 0; //商品总数量
  bool isAllChecked = false;

  save(goodsId, goodsName, count, price, images) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    cartString = sharedPreferences.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    bool isHave = false;

    int ival = 0;
    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if(item['isCheck'] == true){
        allPrice += (cartList[ival].price*cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> map = {
        'isCheck': true,
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(map);
      cartList.add(CartInfoModel.fromJson(map));

      allPrice += price * count;
      allGoodsCount += count;
    }

    cartString = json.encode(tempList).toString();

    sharedPreferences.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartInfo');
    cartList = [];
    allGoodsCount = 0;
    print('清空完成-----------------------------');
    notifyListeners();
  }

  //获取购物车信息
  getCartInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');

    cartList = [];
    allPrice = 0;
    allGoodsCount = 0;
    isAllChecked = true;

    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllChecked = false;
        }

        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除单个购物车商品
  removeGood(String goodsId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
    notifyListeners();
  }

  //改变选中状态
  changeCheckState(CartInfoModel cartInfoModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int modifyIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartInfoModel.goodsId) {
        modifyIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[modifyIndex] = cartInfoModel.toJson();
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
    notifyListeners();
  }

  //全选按钮
  changeAllCheckBtn(bool isCheck) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    for (int i = 0; i < tempList.length; i++) {
      tempList[i]['isCheck'] = isCheck;
    }
    isAllChecked = isCheck;
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
    notifyListeners();
  }

  //商品数量加减
  changeGoodsCount(String goodsId, int todo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    for (int i = 0; i < tempList.length; i++) {
      if (tempList[i]['goodsId'] == goodsId) {
        if (todo == 0) {
          if (tempList[i]['count'] > 1) {
            tempList[i]['count'] = tempList[i]['count'] - 1;
          }
        } else {
          tempList[i]['count'] = tempList[i]['count'] + 1;
        }
        break;
      }
    }
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
    notifyListeners();
  }
}
