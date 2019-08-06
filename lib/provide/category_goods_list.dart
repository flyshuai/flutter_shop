import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';


class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryGoodsListData> categoryGoodsList = [];
  getCategoryGoodsList(List<CategoryGoodsListData> list){
    categoryGoodsList = list;
    notifyListeners();
  }

  getMoreCategoryGoodsList(List<CategoryGoodsListData> list){
    categoryGoodsList.addAll(list);
    notifyListeners();
  }
}