class BillInfoSellingResponseModel {
  int? billNum;
  int? productID;
  String? name;
  int? quantity;
  int? cost;
  int? total;

  BillInfoSellingResponseModel({
    this.billNum,
    this.productID,
    this.name,
    this.quantity,
    this.cost,
    this.total,
  });

  factory BillInfoSellingResponseModel.fromJson(Map<String, dynamic> json) {
    return BillInfoSellingResponseModel(
      billNum: json['Bill_Num'],
      productID: json['Product_ID'],
      name: json['Name'],
      quantity: json['Quantity'],
      cost: json['Cost'],
      total: json['Total'],
    );
  }

  static List<BillInfoSellingResponseModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => BillInfoSellingResponseModel.fromJson(item)).toList();
  }
}

class BillResponseData {
  List<BillInfoSellingResponseModel>? items;
  int? grandTotal;

  BillResponseData({
    this.items,
    this.grandTotal,
  });

  factory BillResponseData.fromJson(Map<String, dynamic> json) {
    return BillResponseData(
      items: BillInfoSellingResponseModel.listFromJson(json['items']),
      grandTotal: json['grandTotal'],
    );
  }
}
