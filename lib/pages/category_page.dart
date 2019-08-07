import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'dart:convert';
import 'package:flutter_shop/model/category.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftCategoryNav(),
              Column(
                children: <Widget>[ChildCategoryNav(), CategoryGoodsList()],
              )
            ],
          ),
        ));
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, list[index].mallCategoryId);
        _getGoodsList(categoryId: list[index].mallCategoryId);

        setState(() {
          listIndex = index;
        });
      },
      child: Container(
        height: ScreenUtil().setHeight(120),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
            color: isClick ? Colors.black12 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel categoryBigListModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryBigListModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? 4 : categoryId,
      'categorySubId': "",
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getCategoryGoodsList(categoryGoodsListModel.data);
    });
  }
}

//右侧顶部子导航
class ChildCategoryNav extends StatefulWidget {
  @override
  _ChildCategoryNavState createState() => _ChildCategoryNavState();
}

class _ChildCategoryNavState extends State<ChildCategoryNav> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setWidth(870),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _childInkWell(
                  childCategory.childCategoryList[index], index);
            }),
      );
    });
  }

  Widget _childInkWell(BxMallSubDto item, index) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(38),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsListModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(categoryGoodsListModel.data);
      }
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data) {
      try {
        if (Provide.value<ChildCategory>(context).page == 1) {
          //列表位置放到最上边
          scrollController.jumpTo(0.0);
        }
      } catch (e) {
        print('进入页面第一次初始化${e}');
      }
      if (data.categoryGoodsList.length > 0) {
        return Expanded(
          child: Container(
              width: ScreenUtil().setWidth(870),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载',
                  key: _footerKey,
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.categoryGoodsList.length,
                  itemBuilder: (content, index) {
                    return _listItemWidget(data.categoryGoodsList, index);
                  },
                ),
                loadMore: () async {
                  print('开始加载更多。。。。');
                  _getGoodsList();
                },
              )),
        );
      } else {
        return Text('暂时没有商品');
      }
    });
  }

  //列表商品图片
  Widget _goodsImage(List list, index) {
    return Container(
      width: ScreenUtil().setWidth(250),
      child: Image.network(list[index].image),
    );
  }

  //列表商品名
  Widget _goodsName(List list, index) {
    return Container(
      width: ScreenUtil().setWidth(450),
      padding: EdgeInsets.all(5.0),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //列表商品价格
  Widget _goodsPrice(List list, index) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: ScreenUtil().setWidth(450),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].presentPrice}',
            style: TextStyle(
                color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(32)),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }

  //列表商品(图片+商品名+商品价格)
  Widget _listItemWidget(List list, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getGoodsList() async {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);

      if (categoryGoodsListModel.data == null) {
        Fluttertoast.showToast(
            msg: '已经到底了',
//            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Provide.value<ChildCategory>(context).changeNoMoreText('没有更多了');
      } else {
        print(categoryGoodsListModel.data[0].goodsName);
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreCategoryGoodsList(categoryGoodsListModel.data);
      }
    });
  }
}
