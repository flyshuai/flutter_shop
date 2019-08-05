import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routers.dart';

import 'Test/testDio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Routers.configureHandler(Application.router);




    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pinkAccent
        ),
//        home: IndexPage(),
      home: IndexPage(),
      ),
    );
  }
}
