import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;

  LeaderPhone({Key key, this.leaderPhone, this.leaderImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _launchURL();
        },
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async{
    String url = 'tel:'+leaderPhone;
//    String url = 'http://jspang.com';
    if(await canLaunch(url)){
      print(url);
      await launch(url);
    }else{
      throw 'url不能进行访问，异常';
    }
  }
}
