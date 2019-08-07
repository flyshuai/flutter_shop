import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_methods.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel detailsModel;

  //从后台获取商品数据
  getGoodDetails(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString());
      print(responseData);
      detailsModel = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
