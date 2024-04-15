/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
// class BillInfoResponseModel {
//   int? billNum;
//   int? productID;
//   int? quantity;
//   int? cost;
//
//   BillInfoResponseModel({this.billNum, this.productID, this.quantity, this.cost});
//
//   BillInfoResponseModel.fromJson(Map<String, dynamic> json) {
//     billNum = json['Bill_Num'];
//     productID = json['Product_ID'];
//     quantity = json['Quantity'];
//     cost = json['Cost'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['Bill_Num'] = billNum;
//     data['Product_ID'] = productID;
//     data['Quantity'] = quantity;
//     data['Cost'] = cost;
//     return data;
//   }
// }
//
// class BillInfoResponseModel {
//   int? billNum;
//   int? productID;
//   int? quantity;
//   int? cost;
//
//   BillInfoResponseModel({this.billNum, this.productID, this.quantity, this.cost});
//
//   factory BillInfoResponseModel.fromJson(Map<String, dynamic> json) {
//     return BillInfoResponseModel(
//       billNum: json['Bill_Num'],
//       productID: json['Product_ID'],
//       quantity: json['Quantity'],
//       cost: json['Cost'],
//     );
//   }
//
//   static List<BillInfoResponseModel> listFromJson(List<dynamic> jsonList) {
//     return jsonList.map((item) => BillInfoResponseModel.fromJson(item)).toList();
//   }
// }
class BillInfoResponseModel {
  int? billNum;
  int? productID;
  String? name;
  int? quantity;
  int? cost;
  int? total;

  BillInfoResponseModel({
    this.billNum,
    this.productID,
    this.name,
    this.quantity,
    this.cost,
    this.total,
  });

  factory BillInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return BillInfoResponseModel(
      billNum: json['Bill_Num'],
      productID: json['Product_ID'],
      name: json['Name'],
      quantity: json['Quantity'],
      cost: json['Cost'],
      total: json['Total'],
    );
  }

  static List<BillInfoResponseModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => BillInfoResponseModel.fromJson(item)).toList();
  }
}

class BillResponseData {
  List<BillInfoResponseModel>? items;
  int? grandTotal;

  BillResponseData({
    this.items,
    this.grandTotal,
  });

  factory BillResponseData.fromJson(Map<String, dynamic> json) {
    return BillResponseData(
      items: BillInfoResponseModel.listFromJson(json['items']),
      grandTotal: json['grandTotal'],
    );
  }
}
