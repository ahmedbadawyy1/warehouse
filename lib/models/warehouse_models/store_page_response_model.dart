// class StorePageResponseModel {
//   int productId;
//   String name;
//   int price;
//   String category;
//   String source;
//   String productNum;
//   DateTime date;
//   String model;
//   String serial;
//   int quantity;
//   String buyer;
//   String receiver;
//
//   StorePageResponseModel({
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.source,
//     required this.productNum,
//     required this.date,
//     required this.model,
//     required this.serial,
//     required this.quantity,
//     required this.buyer,
//     required this.receiver,
//   });
//
//   factory StorePageResponseModel.fromJson(Map<String, dynamic> json) => StorePageResponseModel(
//     productId: json["Product_ID"],
//     name: json["Name"],
//     price: json["Price"],
//     category: json["Category"],
//     source: json["Source"],
//     productNum: json["Product_Num"],
//     date: DateTime.parse(json["Date"]),
//     model: json["Model"],
//     serial: json["Serial"],
//     quantity: json["Quantity"],
//     buyer: json["Buyer"],
//     receiver: json["Receiver"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Product_ID": productId,
//     "Name": name,
//     "Price": price,
//     "Category": category,
//     "Source": source,
//     "Product_Num": productNum,
//     "Date": date.toIso8601String(),
//     "Model": model,
//     "Serial": serial,
//     "Quantity": quantity,
//     "Buyer": buyer,
//     "Receiver": receiver,
//   };
// }
class StorePageResponseModel {
  double productId;
  String name;
  double price;
  String category;
  String source;
  String productNum;
  DateTime date;
  String model;
  String serial;
  double quantity;
  String buyer;
  String receiver;

  StorePageResponseModel({
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

  factory StorePageResponseModel.fromJson(Map<String, dynamic> json) =>
      StorePageResponseModel(
        productId: json["Product_ID"].toDouble(),
        name: json["Name"],
        price: json["Price"].toDouble(),
        category: json["Category"],
        source: json["Source"],
        productNum: json["Product_Num"],
        date: DateTime.parse(json["Date"]),
        model: json["Model"],
        serial: json["Serial"],
        quantity: json["Quantity"].toDouble(),
        buyer: json["Buyer"],
        receiver: json["Receiver"],
      );

  Map<String, dynamic> toJson() => {
    "Product_ID": productId,
    "Name": name,
    "Price": price,
    "Category": category,
    "Source": source,
    "Product_Num": productNum,
    "Date": date.toIso8601String(),
    "Model": model,
    "Serial": serial,
    "Quantity": quantity,
    "Buyer": buyer,
    "Receiver": receiver,
  };
}
