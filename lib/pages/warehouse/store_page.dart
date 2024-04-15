import 'package:flutter/material.dart';
import '../../models/warehouse_models/store_page_response_model.dart';
import '../../services/apiservices.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  APIService _apiService = APIService();
  List<StorePageResponseModel> apiResponse = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      List<StorePageResponseModel> fetchedData = await _apiService.fetchGoods();

      setState(() {
        apiResponse = fetchedData;
      });
    } catch (e) {
      // Handle any potential errors during the API call
      print('Error fetching data: $e');
    }
  }

  Widget buildDataTable() {
    List<StorePageResponseModel> filteredData = searchText.isEmpty
        ? apiResponse
        : apiResponse.where((item) {
      // Implement your search logic here
      return item.name.toLowerCase().contains(searchText.toLowerCase()) ||
          item.category.toLowerCase().contains(searchText.toLowerCase()) ||
          item.productId.toString().contains(searchText.toLowerCase()) ||
          item.productNum.toLowerCase().contains(searchText.toLowerCase()) ||
          // Add other fields as needed for searching
          item.buyer.toLowerCase().contains(searchText.toLowerCase());
      // Repeat the same pattern for other fields
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 10.0, // Adjust column spacing here
          columns: [
            DataColumn(label: Text('Product ID', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Name', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Price', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Category', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Source', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Product Number', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Date', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Model', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Serial', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Quantity', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Buyer', textDirection: TextDirection.rtl)),
            DataColumn(label: Text('Receiver', textDirection: TextDirection.rtl)),
          ],
          rows: filteredData.map((item) {
            return DataRow(cells: [
              DataCell(Text(item.productId.toString(), textDirection: TextDirection.rtl)),
              DataCell(Text(item.name, textDirection: TextDirection.rtl)),
              DataCell(Text(item.price.toString(), textDirection: TextDirection.rtl)),
              DataCell(Text(item.category, textDirection: TextDirection.rtl)),
              DataCell(Text(item.source, textDirection: TextDirection.rtl)),
              DataCell(Text(item.productNum, textDirection: TextDirection.rtl)),
              DataCell(Text(item.date.toString(), textDirection: TextDirection.rtl)),
              DataCell(Text(item.model, textDirection: TextDirection.rtl)),
              DataCell(Text(item.serial, textDirection: TextDirection.rtl)),
              DataCell(Text(item.quantity.toString(), textDirection: TextDirection.rtl)),
              DataCell(Text(item.buyer, textDirection: TextDirection.rtl)),
              DataCell(Text(item.receiver, textDirection: TextDirection.rtl)),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2, // Adjust the height of the image container
              child: Center(
                child: Image.asset(
                  'images/Picture1.jpg', // Replace with your image path
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: apiResponse.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildDataTable(),
            ),
          ),
        ],
      ),
    );
  }
}