import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'package:flutter_shop/config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = new TextEditingController();

  String homePageContent = '正在获取数据';

  void initState(){
    getHomePageContent().then((value){
      setState(() {
        homePageContent = value.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(homePageContent)
          ],
        ),
      ),
    ));
  }
}
