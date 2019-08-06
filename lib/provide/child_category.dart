import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';


class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String categoryId = '4';//大类Id
  String subId = '';
  int page = 1;
  String noMoreText = '';
  //大类切换逻辑
  getChildCategory(List<BxMallSubDto> list,String id){
    page = 1;
    childIndex = 0;
    noMoreText = '';
    categoryId = id;
    BxMallSubDto bxMallSubDtoAll = new BxMallSubDto();
    bxMallSubDtoAll.mallCategoryId='00';
    bxMallSubDtoAll.mallSubName='全部';
    bxMallSubDtoAll.mallSubId='';
    bxMallSubDtoAll.comments='null';
    childCategoryList = [bxMallSubDtoAll];
    childCategoryList.addAll(list);
    notifyListeners();

  }

  //改变子类索引
  changeChildIndex(index,String id){
    page = 1;
    noMoreText = '';
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  //增加page的方法
  addPage(){
    page++;
  }

  changeNoMoreText(String str){
    noMoreText = str;
    notifyListeners();
  }

}