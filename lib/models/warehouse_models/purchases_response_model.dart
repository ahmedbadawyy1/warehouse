class PurchasesResponseModel {
  int? billNum;
  DateTime? date;
  String? buyer;

  PurchasesResponseModel({this.billNum, this.date, this.buyer});

  PurchasesResponseModel.fromJson(Map<String, dynamic> json) {
    billNum = json['Bill_Num'];
    date = json['Date'] != null ? DateTime.parse(json['Date']) : null;
    buyer = json['Buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Bill_Num'] = billNum;
    data['Date'] = date?.toIso8601String(); // Convert DateTime to ISO 8601 string
    data['Buyer'] = buyer;
    return data;
  }
}
