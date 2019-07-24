import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = new TextEditingController();
  String showText = "欢迎来到美好人间";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('请求远程数据'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {jike();},
                  child: Text('请求数据'),
                ),
                Text(showText)
              ],
            ),
          ),
        ));
  }

  void jike(){
    print('开始请求数据');
    getHttp().then((value){
      setState(() {
        showText = value['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      //伪造请求头
      dio.options.headers = httpHeaders;
      response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(response);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
