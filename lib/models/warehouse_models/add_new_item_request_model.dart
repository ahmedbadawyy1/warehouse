class AddNewItemRequestModel {
  int productId;
  String name;
  double price;
  String category;
  String source;
  String productNum;
  String date;
  String model;
  String serial;
  int quantity;
  String buyer;
  String receiver;

  AddNewItemRequestModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.category,
    required this.source,
    required this.productNum,
    required this.date,
    required this.model,
    required this.serial,
    required this.quantity,
    required this.buyer,
    required this.receiver,
  });

  factory AddNewItemRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewItemRequestModel(
      productId: json['Product_ID'],
      name: json['Name'],
      price: json['Price'].toDouble(),
      category: json['Category'],
      source: json['Source'],
      productNum: json['Product_Num'],
      date: json['Date'],
      model: json['Model'],
      serial: json['Serial'],
      quantity: json['Quantity'],
      buyer: json['Buyer'],
      receiver: json['Receiver'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Product_ID': productId,
      'Name': name,
      'Price': price,
      'Category': category,
      'Source': source,
      'Product_Num': productNum,
      'Date': date,
      'Model': model,
      'Serial': serial,
      'Quantity': quantity,
      'Buyer': buyer,
      'Receiver': receiver,
    };
    return data;
  }
}
