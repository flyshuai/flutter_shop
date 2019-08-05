import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_handler.dart';
import 'package:flutter/material.dart';

class Routers {
  static String root = '/';
  static String detailsPage = '/details';

  static void configureHandler(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('qweqeqweqeqqee');
      },
    );

    router.define(detailsPage, handler: detailsHandler);
  }
}
