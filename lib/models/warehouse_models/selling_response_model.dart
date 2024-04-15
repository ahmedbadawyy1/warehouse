class SellingResponseModel {
  int? billNum;
  DateTime? date;
  String? seller;
  String? receiver;

  SellingResponseModel({this.billNum, this.date, this.seller, this.receiver});

  SellingResponseModel.fromJson(Map<String, dynamic> json) {
    billNum = json['Bill_Num'];
    date = json['Date'] != null ? DateTime.parse(json['Date']) : null;
    seller = json['Seller'];
    receiver = json['Receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Bill_Num'] = billNum;
    data['Date'] = date?.toIso8601String(); // Convert DateTime to ISO 8601 string
    data['Seller'] = seller;
    data['Receiver'] = receiver;
    return data;
  }
}
