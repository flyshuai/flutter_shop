class DetailsModel {
    Data data;
    String code;
    String message;

    DetailsModel({this.data, this.code, this.message});

    factory DetailsModel.fromJson(Map<String, dynamic> json) {
        return DetailsModel(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            code: json['code'],
            message: json['message'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['message'] = this.message;
        if (this.data != null) {
            data['`data`'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    AdvertesPicture advertesPicture;
    List<GoodComment> goodComments;
    GoodInfo goodInfo;

    Data({this.advertesPicture, this.goodComments, this.goodInfo});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            advertesPicture: json['advertesPicture'] != null ? AdvertesPicture.fromJson(json['advertesPicture']) : null,
            goodComments: json['goodComments'] != null ? (json['goodComments'] as List).map((i) => GoodComment.fromJson(i)).toList() : null,
            goodInfo: json['goodInfo'] != null ? GoodInfo.fromJson(json['goodInfo']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.advertesPicture != null) {
            data['advertesPicture'] = this.advertesPicture.toJson();
        }
        if (this.goodComments != null) {
            data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
        }
        if (this.goodInfo != null) {
            data['goodInfo'] = this.goodInfo.toJson();
        }
        return data;
    }
}

class AdvertesPicture {
    String pICTURE_ADDRESS;
    String tO_PLACE;

    AdvertesPicture({this.pICTURE_ADDRESS, this.tO_PLACE});

    factory AdvertesPicture.fromJson(Map<String, dynamic> json) {
        return AdvertesPicture(
            pICTURE_ADDRESS: json['pICTURE_ADDRESS'],
            tO_PLACE: json['tO_PLACE'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['pICTURE_ADDRESS'] = this.pICTURE_ADDRESS;
        data['tO_PLACE'] = this.tO_PLACE;
        return data;
    }
}

class GoodInfo {
    int amount;
    String comPic;
    String goodsDetail;
    String goodsId;
    String goodsName;
    String goodsSerialNumber;
    String image1;
    String image2;
    String image3;
    String image4;
    String image5;
    String isOnline;
    double oriPrice;
    double presentPrice;
    String shopId;
    int state;

    GoodInfo({this.amount, this.comPic, this.goodsDetail, this.goodsId, this.goodsName, this.goodsSerialNumber, this.image1, this.image2, this.image3, this.image4, this.image5, this.isOnline, this.oriPrice, this.presentPrice, this.shopId, this.state});

    factory GoodInfo.fromJson(Map<String, dynamic> json) {
        return GoodInfo(
            amount: json['amount'],
            comPic: json['comPic'],
            goodsDetail: json['goodsDetail'],
            goodsId: json['goodsId'],
            goodsName: json['goodsName'],
            goodsSerialNumber: json['goodsSerialNumber'],
            image1: json['image1'],
            image2: json['image2'],
            image3: json['image3'],
            image4: json['image4'],
            image5: json['image5'],
            isOnline: json['isOnline'],
            oriPrice: json['oriPrice'],
            presentPrice: json['presentPrice'],
            shopId: json['shopId'],
            state: json['state'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['comPic'] = this.comPic;
        data['goodsDetail'] = this.goodsDetail;
        data['goodsId'] = this.goodsId;
        data['goodsName'] = this.goodsName;
        data['goodsSerialNumber'] = this.goodsSerialNumber;
        data['image1'] = this.image1;
        data['image2'] = this.image2;
        data['image3'] = this.image3;
        data['image4'] = this.image4;
        data['image5'] = this.image5;
        data['isOnline'] = this.isOnline;
        data['oriPrice'] = this.oriPrice;
        data['presentPrice'] = this.presentPrice;
        data['shopId'] = this.shopId;
        data['state'] = this.state;
        return data;
    }
}

class GoodComment {
    String comments;
    int discussTime;
    int sCORE;
    String userName;

    GoodComment({this.comments, this.discussTime, this.sCORE, this.userName});

    factory GoodComment.fromJson(Map<String, dynamic> json) {
        return GoodComment(
            comments: json['comments'],
            discussTime: json['discussTime'],
            sCORE: json['sCORE'],
            userName: json['userName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comments'] = this.comments;
        data['discussTime'] = this.discussTime;
        data['sCORE'] = this.sCORE;
        data['userName'] = this.userName;
        return data;
    }
}