class BillSellingPageRequestModel {
  int? productID;
  int? quantity;
  double? cost;

  BillSellingPageRequestModel({this.productID, this.quantity, this.cost});

  BillSellingPageRequestModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    quantity = json['quantity'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productID'] = productID;
    data['quantity'] = quantity;
    data['cost'] = cost;
    return data;
  }
}

class RootSelling {
  int? billNum;
  String? date;
  String? seller;
  String? receiver;
  List<BillSellingPageRequestModel>? items;

  RootSelling({this.billNum, this.date, this.seller, this.receiver, this.items});

  RootSelling.fromJson(Map<String, dynamic> json) {
    billNum = json['billNum'];
    date = json['date'];
    seller = json['seller'];
    receiver = json['receiver'];
    if (json['items'] != null) {
      items = <BillSellingPageRequestModel>[];
      json['items'].forEach((v) {
        items!.add(BillSellingPageRequestModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['billNum'] = billNum;
    data['date'] = date;
    data['seller'] = seller;
    data['receiver'] = receiver;
    data['items'] = items != null ? items!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
