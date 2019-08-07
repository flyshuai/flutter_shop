import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_methods.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel detailsModel;

  bool isLeft = true;
  bool isRight = false;

  //从后台获取商品数据
  getGoodDetails(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString());
      detailsModel = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  changeTab(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
