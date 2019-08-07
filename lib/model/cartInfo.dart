class CartInfoModel {
  int count;
  String goodsId;
  String goodsName;
  String images;
  double price;

  CartInfoModel(
      {this.count, this.goodsId, this.goodsName, this.images, this.price});

  factory CartInfoModel.fromJson(Map<String, dynamic> json) {
    return CartInfoModel(
      count: json['count'],
      goodsId: json['goodsId'],
      goodsName: json['goodsName'],
      images: json['images'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['images'] = this.images;
    data['price'] = this.price;
    return data;
  }
}
