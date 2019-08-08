import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/provide/currentIndexProvide.dart';
import 'package:provide/provide.dart';

import 'flutter_probide_demo_page.dart';


class IndexPage extends StatelessWidget {

  final List<BottomNavigationBarItem> bottomsTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];
  
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080,height:1534)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,//
            currentIndex: currentIndex,
            items: bottomsTabs,
            onTap: (index){
              print(index);
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}




//class IndexPage extends StatefulWidget {
//  @override
//  _IndexPageState createState() => _IndexPageState();
//}
//
//class _IndexPageState extends State<IndexPage> {
//  final List<BottomNavigationBarItem> bottomsTabs = [
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
//  ];
//
//  final List<Widget> tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];
//
//  int currentIndex = 0;
//  var currentPage;
//
//  @override
//  void initState() {
//    currentPage = tabBodies[currentIndex];
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 1080,height:1534)..init(context);
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,//
//        currentIndex: currentIndex,
//        items: bottomsTabs,
//        onTap: (index){
//          setState(() {
//            currentIndex = index;
//            currentPage = tabBodies[currentIndex];
//          });
//        },
//      ),
//      body: IndexedStack(
//        index: currentIndex,
//        children: tabBodies,
//      ),
//    );
//  }
//}
