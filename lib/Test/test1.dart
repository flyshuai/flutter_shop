import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
            title: Text('美好人间'),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: typeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: '类型',
                      helperText: '请输入类型',
                    ),
                    autofocus: false,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _choiceAction();
                    },
                    child: Text('确定'),
                  ),
                  Text(
                    showText,
                    overflow: TextOverflow.ellipsis, //超出显示
                    maxLines: 1,
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _choiceAction() {
    if (typeController.text.toString().trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('类型不能为空！'),
          ));
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          showText = value['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response = new Response();
      var data = {'name': typeText};
      response = await Dio().post(
          'https://www.easy-mock.com/mock/5d38034459594931f369a02f/example/dabaojian_post',
          queryParameters: data);
//      https://www.easy-mock.com/mock/5d38034459594931f369a02f/example/dabaojian_post
      return response.data;
    } catch (exception) {
      return print(exception);
    }
  }
}