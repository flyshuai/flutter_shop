import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../config/httpHeaders.dart';

Future request(String url, {formData}) async {
  try {
    print(url+'开始获取数据。。。。。');
    Dio dio = new Dio();

    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    Response response;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
//    print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw new Exception('ERROR:=========>后端接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:=========>${e}');
  }
}

