import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future getHomePageContent(String url, {formData}) async {
  try {
    print('开始获取数据。。。。。');
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    Response response;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw new Exception('ERROR:=========>后端接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:=========>${e}');
  }
}

//获取首页主体内容
//Future getHomePageContent() async {
//  try {
//    print('开始获取首页数据。。。。。');
//    Dio dio = new Dio();
//    dio.options.contentType =
//        ContentType.parse('application/x-www-form-urlencoded');
//    var formData = {'lon': '115.02932', 'lat': '35.76189'};
//    Response response =
//        await dio.post(servicePath['homePageContent'], data: formData);
//    print(response);
//    if (response.statusCode == 200) {
//      return response.data;
//    } else {
//      throw new Exception('ERROR:=========>后端接口出现异常.');
//    }
//  } catch (e) {
//    return print('ERROR:=========>${e}');
//  }
//}

//获取火爆专区的商品
Future getHomePageBelowConten() async {
  try {
    print('开始获取获取火爆专区。。。。。');
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    int page = 1;
    Response response =
        await dio.post(servicePath['homePageBelowConten'], data: page);
    print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw new Exception('ERROR:=========>后端接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:=========>${e}');
  }
}
