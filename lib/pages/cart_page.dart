import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page/cart_bottom.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';
import 'package:flutter_shop/provide/cartProvide.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartProvide>(context).cartList;

            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, data) {
                    cartList = Provide.value<CartProvide>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
        future: _getCartInfo(context),
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
