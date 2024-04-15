import 'package:flutter/material.dart';
import '../../models/warehouse_models/bill_page_request_purchases_model.dart';
import '../../models/warehouse_models/bill_page_response_purchases_model.dart';
import '../../services/apiservices.dart';

class AddBill extends StatefulWidget {
  const AddBill({Key? key}) : super(key: key);

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  final APIService _apiService = APIService();
  List<Map<String, dynamic>> items = [];

  TextEditingController itemCodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController billNumberController = TextEditingController();
  TextEditingController fromController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateController.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Bill',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: _buildItemForm(),
                    ),
                  ),
                  SizedBox(width: 20), // Add some space between the columns
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _buildDataTable(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: _submitBillData,
                  child: Text('Save Bill'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget _buildDataTable() {
  //   return SingleChildScrollView(
  //     child: DataTable(
  //       columnSpacing: 20,
  //       dataRowHeight: 50,
  //       columns: [
  //         DataColumn(label: Text('Bill Number')),
  //         DataColumn(label: Text('Date')),
  //         DataColumn(label: Text('From')),
  //         DataColumn(label: Text('Item Code')),
  //     //    DataColumn(label: Text('Description')),
  //         DataColumn(label: Text('Quantity')),
  //         DataColumn(label: Text('Price')),
  //      //   DataColumn(label: Text('Tax')),
  //     //    DataColumn(label: Text('Total')),
  //       ],
  //       rows: items.map((item) {
  //         return DataRow(cells: [
  //           DataCell(Text(item['BillNumber'] ?? '')),
  //           DataCell(Text(item['Date'] ?? '')),
  //           DataCell(Text(item['from'] ?? '')),
  //           DataCell(Text(item['itemCode'] ?? '')),
  //        //   DataCell(Text(item['description'] ?? '')),
  //           DataCell(Text(item['quantity'] != null ? '${item['quantity']}' : '')),
  //           DataCell(Text(item['price'] != null ? '${item['price']}' : '')),
  //
  //        //   DataCell(Text(item['tax'] != null ? '${item['tax']}' : '')),
  //      //     DataCell(Text(item['total'] != null ? '${item['total']}' : '')),
  //         ]);
  //       }).toList(),
  //
  //     ),
  //   );
  // }
  void _addItem() {
    double? price = double.tryParse(priceController.text);
    int? quantity = int.tryParse(quantityController.text);

    if (price != null && quantity != null) {
      setState(() {
        items.add({
          'BillNumber': int.tryParse(billNumberController.text) ?? 0,
          'Date': dateController.text,
          'from': fromController.text,
          'itemCode': int.tryParse(itemCodeController.text) ?? 0,
          'quantity': quantity,
          'price': price,
        });

        // Clear text fields after adding item
        itemCodeController.clear();
        priceController.clear();
        quantityController.clear();
      });
    } else {
      // Show error message if any field has invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid input in one or more fields.')),
      );
    }
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      child: DataTable(
        columnSpacing: 20,
        dataRowHeight: 50,
        columns: [
          DataColumn(label: Text('Bill Number')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('From')),
          DataColumn(label: Text('Item Code')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price')),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            DataCell(Text(item['BillNumber'].toString())),
            DataCell(Text(item['Date'] ?? '')),
            DataCell(Text(item['from'] ?? '')),
            DataCell(Text(item['itemCode'].toString())),
            DataCell(Text('${item['quantity']}')),
            DataCell(Text('${item['price']}')),
          ]);
        }).toList(),
      ),
    );
  }


  Widget _buildItemForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: billNumberController,
            decoration: InputDecoration(
              labelText: 'Bill Number',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: fromController,
            decoration: InputDecoration(
              labelText: 'From',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: itemCodeController,
            decoration: InputDecoration(
              labelText: 'Item Code',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 8),

          TextFormField(
            controller: quantityController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Quantity',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.green), // Change focused border color here
              ),

            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.green), // Change focused border color here
              ),
            ),
          ),
          SizedBox(height: 8),

          ElevatedButton(
            onPressed: () {
              _addItem();
            },
            child: Text('Add Item'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitBillData() async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add items to the bill first.')),
      );
      return;
    }

    try {
      Root billData = Root(
        billNum: int.tryParse(billNumberController.text) ?? 0,
        date: dateController.text,
        buyer: fromController.text,
        items: items
            .map((item) =>
            BillPageRequestModel(
              productID: item['itemCode'],
              quantity: item['quantity'],
              cost: item['price'],
            ))
            .toList(),
      );

      BillResponseModel response = await _apiService.postBillData(billData);

      // Handle successful response
      print('Response message: ${response.message}');

      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bill submitted successfully')),
      );

      // Clear the items list after successful submission
      setState(() {
        items.clear();

        // Clear text controllers
        billNumberController.clear();
        dateController.clear();
        fromController.clear();
        itemCodeController.clear();
        quantityController.clear();
        priceController.clear();
      });
    } catch (e) {
      // Handle errors during API call
      print('Error: $e');

      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit the bill. Please try again.')),
      );
    }
  }
}