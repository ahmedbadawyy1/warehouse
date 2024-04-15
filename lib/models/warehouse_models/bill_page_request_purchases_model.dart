
class BillPageRequestModel {
  int? productID;
  int? quantity;
  double? cost;

  BillPageRequestModel({this.productID, this.quantity, this.cost});

  BillPageRequestModel.fromJson(Map<String, dynamic> json) {
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

class Root {
  int? billNum;
  String? date;
  String? buyer;
  List< BillPageRequestModel?>? items;

  Root({this.billNum, this.date, this.buyer, this.items});

  Root.fromJson(Map<String, dynamic> json) {
    billNum = json['billNum'];
    date = json['date'];
    buyer = json['buyer'];
    if (json['items'] != null) {
      items = < BillPageRequestModel>[];
      json['items'].forEach((v) {
        items!.add( BillPageRequestModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['billNum'] = billNum;
    data['date'] = date;
    data['buyer'] = buyer;
    data['items'] =items != null ? items!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

