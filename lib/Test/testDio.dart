import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestDio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _login();
    return Container(
      child: Text('test'),
    );
  }

  _login() async {
    String userName = 'fly';
    String password = '123456';

    Map<String, dynamic> param = {
      'usernameOrEmailAddress': userName,
      'password': password,
//      'yazm': 'kdbf',
//      'tenancyName': '',
//      'returnUrlHash': '#!/h',
//      'rememberMe': false
    };

    Dio dio = new Dio();
    String result;
    String sessionid = await _getSessionId();
    String cookie =
        'Abp.Localization.CultureName=zh-CN; ASP.NET_SessionId=${sessionid}; ';
    try {
      dio.options.headers['Cookie'] = cookie;
      Response response = await dio.post(
          'http://106.14.163.188:6010/Manage/Account/Login?returnUrl=none',
          queryParameters: param);
      print(response.headers['set-cookie']);
      if (response.data['success'] == true) {
        String temp = response.headers['set-cookie'][1];
        print(temp);
        int endIndex = temp.indexOf(";");
        cookie =cookie+temp.substring(0,endIndex+1);
        dio.options.headers['Cookie'] =cookie;
        response = await dio.get(
            'http://106.14.163.188:6010/api/services/owacp/session/GetCurrentLoginInformations');
        print(response);
      } else {}
    } catch (exception) {
      result = 'Failed getting IP address';
      print(result);
    }
  }

  //生成24位sessionId
  Future<String> _getSessionId () async{
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 24; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }


}
